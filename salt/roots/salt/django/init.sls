{% set database_name = salt['pillar.get']('database_name') %}

include:
  - requirements

create_db:
  module.run:
    - name: mysql.db_create
    - m_name: {{ database_name }}
    - character_set: "utf8"
    - require:
      - sls: requirements

create_user:
  module.run:
    - name: mysql.user_create
    - user: jangow
    - password: djingle
    - require: 
      - sls: requirements

mysql.grant_add:
  module.run:
    - grant: 'ALL'
    - database: "{{ database_name }}.*"
    - user: 'jangow'
    - require: 
      - sls: requirements
      - module: create_user
      - module: create_db
 
django:
  pip.installed:
    - name: django == 1.6.5
    - require:
      - sls: requirements

python-django:
  pkg.installed:
    - require:
      - sls: requirements
