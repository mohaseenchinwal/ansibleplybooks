# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

export http_proxy='http://proxy:3128/'
export HTTP_PROXY="$http_proxy"
export https_proxy='https://proxy:3128/'
export HTTPS_PROXY="$http_proxy"
export PS1="[\\u@\h.pri:\w\$]"
