tmux:
  pkg.installed

django_tmux:
  cmd.script:
    - source: salt://playing_god/files/django_tmux.sh
    - shell: /bin/bash
    - user: vagrant

