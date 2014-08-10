{#

Install git
Add key for salt user
Clone Sanit code

#}

{% set hogdir="/var/salt/sanitisation" %}

include:
  - .user
  
sanit_github:
  pkg.installed:
    - name: git
  ssh_known_hosts.present:
    - name: github.hogarthww.prv
    - user: salt
    - fingerprint: 41:ec:09:b2:9f:bb:ba:2f:dd:90:ec:2c:ea:e2:26:db
    - require:
      - user: salt
  file.managed:
    - name: /var/salt/.ssh/id_rsa
    - contents: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpQIBAAKCAQEAzko1NoMnjzCwO59Y6iQ6cqjjDn/S5qOsm3uSd98YfTl1P4Rv
        QcvmBAba2yR7kDH+urx/Nl1CB3CU/xY5oENC9TwZHWpuLERiT/GSBFiCA/T+u2Cl
        HKQqv1psZSjB+ouzbNHyvPlepUX2kPqSMuw8/wJYAjjA7f9MBihUyy93l8sKXqkF
        tL49LCOj+Gdqk7+UkxZIU/4NqByo2+WNCUt250OtERSwOs7MtXOqMvo3PeyJIgzV
        wRvrddnk5i4NJOJ41KA/PqPf2ei3Ehlr9OGfwg2XFCuzibhxk6E5ZWgVKVrCRI6d
        Kvyh9Mv1IDEGEUwlyS/D8PEFQ3Pn3Wz/6ov3VwIDAQABAoIBAQCl25w1G/YudmL7
        TP7cIgysK4WDHtqefXJGAHCe2EyEQjI2w3AAYsOo8Sn9j7OZF9lKoktVll2ERcxF
        28SxSeMH8S3wLKYwCTtSM1PHErJWJCC63tVh1cxY1YbZPo/XtYKpN5QGxCiIkVvQ
        7OWm87GHBodkIeVcdSrWuI6UXrG05CMEMO7aNABMmNcRmqeyTLBVeT4U3xs4rSSi
        A9vMBeWuiHXZvgFrx7mMZVehEYxe1vPN4my5ynQnz5gwJU5JwMOFpCDjF+xAg5As
        lP96LZQDk2nVJmcd3gDFMIFdTNEiOaYivMXhLDeeyquc9NmlJvHaRm97fkGBNQ1L
        7kFdMA8BAoGBAP8Hawi+BNBsNz6AV2pCiPAlwU2yMqjtSlBtD4mgC6SVptn0IpYB
        HvjF6JMaP215w4ditgYUs56SONPXXTECK4dVv/3se94kGwHp99bj8lIl71/RjKpm
        qw33L6ZLMwEOc78MpqoiqiXyyaspT05XQrTE/UMCjFInvV3TONkwqUUhAoGBAM8T
        SGPKp36qJvOiTY+T6HKgoRVhxi9Ov8en8v/k6sV9j6qLVGvqeDPDPWnkT66dkXM3
        d6Q3+/K0srFoEUpKUzkO5pkCb3K3B10y/SnL0s1/UfEGLmqJikbQdiEOhGAnXYR4
        UInZEZdqBr86pQ1wYV1EDhOMjkNx45gCBjkh7TV3AoGBALAgomYWPWLn6btLjZOA
        QeyAVqDfGaeawYEL4PguRPw0slfCCITKX2Z13+p/7SAhQM1mecl3UJmJ6J89FEo9
        cmxz5zVpth4zl0daG2UYZgkf09K7+MbSQv5RIWJaeu4W2g8uoIfNiu7MX0TLMc8r
        6pDHnxVBVEGE2n5K2u78cVqhAoGBAK/KmuW8oLyzDiY+XsHIusi0/Ir+WhTHMZ/5
        QB1k5LmLgm8xoRWME0c+M+C1Zb/DHDtHl1XeARFlvV1GD4eV2VjTAYhbvOkR4DqK
        ksjss6SotZN7v+PJp42+YsplXJOUV5uh2B1uHbUA2YF187CY+s8Gezy1UgCHqsLc
        1ROjbZC5AoGABPlHkxfBOGeivOTu/bYpqohktodBSvmSGwm94dIeMh9f0d6ZFUxa
        KbOiuTjSeeChZVrhhlENMFWe5akTBu0ESE4Q7rPQI9xSWEaoOZW5Fisc0DdEyq+3
        yD2A8Yp7IdCxWofgpW8WFz9MFJ9swIfoLTa/N4tVDiBaEdwhZomrtGk=
        -----END RSA PRIVATE KEY-----
    - mode: 600
    - user: salt
    - require:
      - file: /var/salt/.ssh
  git.latest:
    - name: git@github.hogarthww.prv:sysads/Sanitisation.git
    - target: {{ hogdir }}
    - user: salt
    - force: True
    - force_checkout: True
    - submodules: True
    - always_fetch: True
    - require:
      - pkg: git
      - ssh_known_hosts: github.hogarthww.prv
      - file: /var/salt/.ssh/id_rsa
{#
change_to_syslog_branch:
  module.run:
    - name: git.checkout
    - cwd: {{ hogdir }}
    - rev: syslog
#}

