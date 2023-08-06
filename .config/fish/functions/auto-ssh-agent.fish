function auto-ssh-agent --description 'automatically set SSH_AUTH_SOCK to most recent agent'
 set -x SSH_AUTH_SOCK (fd -p /ssh-\.\*\/agent\. /tmp)
end
