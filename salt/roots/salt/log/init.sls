{#

Create requisite files and folders needed for sanitisation

#}

include:
  - .git
  - .cron
  - .logstash_run

{% set s_root = "/opt/hogarth/sanitisation" %} 
{% set folders_to_create = salt['pillar.get']('folders') %}

/opt/hogarth:
  file.directory:
    - mode: 755

copy_sanitisation:
  cmd.run:
    - name: rsync -rv --exclude=".git*" /var/salt/sanitisation /opt/hogarth/

{% for f in folders_to_create %}

{{ s_root }}/{{ f }}:
  file.directory:
    - name: {{ s_root }}/{{ f }}
    - mode: 775
     
{{ s_root }}/{{ f }}/.Hidden:
  file.directory:
    - mode: 700 
    - require:
      - file: {{ s_root }}/{{ f }}

{{ s_root }}/{{ f }}/Problem Files:
  file.directory:
    - mode: 777 
    - require:
      - file: {{ s_root }}/{{ f }}

{{ s_root }}/{{ f }}/To Archive:
  file.directory:
    - mode: 777 
    - require:
      - file: {{ s_root }}/{{ f }}

{{ s_root }}/{{ f }}/Logs:
  file.directory:
    - mode: 755 
    - require:
      - file: {{ s_root }}/{{ f }} 

{{ s_root }}/{{ f }}/Destination:
  file.directory:
    - mode: 755

{% if f == 'Rename' %}

{{ s_root }}/{{ f }}/RenamedFiles:
  file.directory:
    - mode: 755
    - require:
      - file: {{ s_root }}/{{ f }}

{% endif %}
{% endfor %}

/var/log/sanitisePathsSysLogs:
  file.directory:
    - mode: 755

{# Create cron entries for rename and log versions of the script #} 

crontab_rename:
  cron.present:
    - identifier: sanitisePathsRename
    - name: /opt/hogarth/sanitisation/sanitisePaths.py -d -t {{ s_root }}/Rename/ -p {{ s_root }}/Rename/Destination -l /var/log/sanitisePathsSysLogs -r {{ s_root }}/Rename/RenamedFiles
    - require:
      - file: {{ s_root }}/Rename 
      - file: /var/log/sanitisePathsSysLogs
      - cmd: copy_sanitisation


crontab_log:
  cron.present:
    - identifier: sanitisePathsLog
    - name: /opt/hogarth/sanitisation/sanitisePaths.py -t {{ s_root }}/Log/ -p {{ s_root }}/Log/Destination -l /var/log/sanitisePathsSysLogs
    - require:
      - file: {{ s_root }}/Log 
      - cmd: copy_sanitisation

manual_cmd:
  cmd.run:
    - name: cp /srv/salt/log/files/manualCommand.sh {{ s_root }}/Manual/manualCommand.sh
  require:
    - file: {{ s_root }}/Manual

{# Copy a test directory to the sanitisation folders #}

copy_test_dir:
  cmd.run:
    - name: cp -r /srv/salt/log/files/saniTestFolder {{ s_root }}
