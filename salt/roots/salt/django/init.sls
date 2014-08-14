{% set database_name = salt['pillar.get']('database_name') %}
python-pip:
  pkg.installed

#Install and configure mysql
mysql-server:
  pkg.installed

python-mysqldb:
  pkg.installed

python-dev:
  pkg.installed

python-virtualenv:
  pkg.installed

create_db:
  module.run:
    - name: mysql.db_create
    - m_name: {{ database_name }}
    - character_set: "utf8"
    - require:
      - pkg: mysql-server

create_user:
  module.run:
    - name: mysql.user_create
    - user: jangow
    - password: djingle
    - require: 
      - pkg: mysql-server
      - pkg: python-mysqldb

mysql.grant_add:
  module.run:
    - grant: 'ALL'
    - database: "{{ database_name }}.*"
    - user: 'jangow'
    - require: 
      - pkg: mysql-server
      - pkg: python-mysqldb
      - module: create_user
      - module: create_db
 
django:
  pip.installed:
    - name: django == 1.6.5
    - require:
      - pkg: python-pip
