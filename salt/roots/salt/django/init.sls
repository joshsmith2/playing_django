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

python-django:
  pkg.installed

create_db:
  module.run:
    - name: mysql.db_create
    - m_name: {{ database_name }}
    - character_set: "utf8"

create_user:
  module.run:
    - name: mysql.user_create
    - user: jangow
    - password: djingle

mysql.grant_add:
  module.run:
    - grant: 'ALL'
    - database: "{{ database_name }}.*"
    - user: 'jangow'
 
django:
  pip.installed:
    - name: django == 1.6.5
    - require:
      - pkg: python-pip

