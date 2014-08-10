include:  
  - .logstash_conf

start_ls_script:
  cmd.script:
    - source: salt://log/files/start_logstash.sh
    - shell: /bin/bash
    - user: vagrant
