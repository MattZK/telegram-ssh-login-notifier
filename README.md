# Telegram SSH Login Notifier
Get a Telegram notification when sombody logs in to a server via SSH.

Set `USERID` & `KEY`

Add to `/etc/pam.d/sshd`
```bash
session    optional     pam_exec.so quiet seteuid /path/to/notify.sh
```