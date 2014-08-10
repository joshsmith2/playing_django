{#

Crontabs in Centos have a nasty habit of being installed without a PATH or a SHELL. This checks for these and inserts them if they're not there. 

#}

cron_set_shell:
  module.run:
    - name: cron.set_env
    - user: "root"
    - m_name: "SHELL" #Used to pass 'name' to the module instead of overwriting the variable above.
    - value: "/bin/bash"

cron_set_path:
  module.run:
    - name: cron.set_env
    - user: "root"
    - m_name: "PATH"
    - value: "/sbin:/bin:/usr/sbin:/usr/bin"

cron_set_home:
  module.run:
    - name: cron.set_env
    - user: "root"
    - m_name: "HOME"
    - value: "/"

