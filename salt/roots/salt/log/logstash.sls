{#
Install logstash as an agent
#}

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
  file.exists

