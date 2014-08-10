include:
  - django

/opt/josh_smith/playing_god:
  file.directory:
    - mode: 755
    - makedirs: True

install_django:
  cmd.run:
    - name: cd /opt/josh_smith/playing_god && django-admin startproject django_god

/opt/josh_smith/playing_god/django_god/django_god/settings.py:
  file.managed: 
    - source: salt://playing_god/files/settings.py
    - user: vagrant

start_django:
  cmd.run:
    - name: python /opt/josh_smith/playing_god/djang_god/manage.py 0.0.0.0:8000
