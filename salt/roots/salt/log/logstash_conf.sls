{#
Install logstash as an agent
#}

{% set log_server = salt['pillar.get']('log_server') %}
{% set l_files = salt['pillar.get']('logstash_files') %}
{% set l_dir = salt['pillar.get']('logstash_dir') %}
{% set l_conf_file = "/etc/logstash/logstash-sani-shipper.conf" %}

/etc/logstash:
  file.directory:
    - mode: 755

/opt/logstash:
  file.directory:
    - mode: 755

default-jre:
  pkg:
    - installed

curl:
  pkg:
    - installed

download_logstash:
  cmd.run:
    - name: curl -o /opt/logstash-1.4.2.tar.gz https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz && tar zxf /opt/logstash-1.4.2.tar.gz --directory /opt/
    - prereq:
      - file: /opt/logstash-1.4.2/bin

/opt/logstash-1.4.2/bin:
  file.directory

conf_file:
  file.managed:
    - source: salt://log/files/logstash-sani-shipper.conf 
    - name: {{ l_conf_file }}
    - user: vagrant
    - mode: 755
    - template: jinja
