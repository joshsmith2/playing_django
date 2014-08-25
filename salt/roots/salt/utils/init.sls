cowsay:
  pkg:
    - installed

vim:
  pkg:
    - installed
  cmd.run:
    - name: cp /srv/salt/utils/files/.vimrc /etc/vim/vimrc

