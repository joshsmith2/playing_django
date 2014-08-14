include:
  - django

/opt/josh_smith:
  file.directory:
    - mode: 755
    - makedirs: True
    - require_in:
      - cmd: install_django
      - file: /opt/josh_smith/django_god/django_god/settings.py
      - cmd: start_django

install_django:
  cmd.run:
    - name: cd /opt/josh_smith && django-admin startproject django_god

/opt/josh_smith/django_god/django_god/settings.py:
  file.managed: 
    - source: salt://playing_god/files/settings.py
    - user: vagrant

start_django:
  cmd.run:
    - name: python /opt/josh_smith/django_god/manage.py runserver 0.0.0.0:8000 &
