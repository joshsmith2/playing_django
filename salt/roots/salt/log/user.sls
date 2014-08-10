salt_auth:
  user.present:
  - name: salt
  - shell: /bin/bash
  - home: /var/salt
  - system: True
  file.directory:
    - name: /var/salt/.ssh
    - user: salt
    - mode: 700
    - require:
      - user: salt