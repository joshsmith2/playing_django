{% set manage = 'cd /opt/josh_smith/django_god && python manage.py' %}

include:
  - .tmux
  - .requirements

/opt/josh_smith:
  file.directory:
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: install_django
      - file: /opt/josh_smith/django_god/django_god/settings.py

install_django:
  cmd.run:
    - name: cd /opt/josh_smith && django-admin startproject django_god

/opt/josh_smith/django_god/django_god/settings.py:
  file.managed: 
    - source: salt://playing_god/files/settings.py
    - user: vagrant

start_app:
  cmd.run:
    - name: {{ manage }} startapp playing_god

/opt/playing_god_git:
  file.directory:
    - mode: 755
    - user: vagrant
    - require_in:
      - git: clone_from_git

clone_from_git:
  git.latest:
    - name: https://github.com/joshsmith2/playingGod.git
    - rev: django
    - target: /opt/playing_god_git
    - user: vagrant
    - require:
      - sls: playing_god.requirements
