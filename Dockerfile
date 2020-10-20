FROM alpine:latest
MAINTAINER kairos03 <kairos9603@gmail.com>

# essential package install
RUN apk update \
    && apk add --no-cache openssh \
    # root passwd
    && echo 'root:P@ssw0rd' | chpasswd \
    # add ssh key
    && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
    # replace sshd_config
    && sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && sed -ri 's/^#?AllowTcpForwarding\s+.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^#?X11DisplayOffset\s+.*/X11DisplayOffset 10/' /etc/ssh/sshd_config \
    && sed -ri 's/^#?TCPKeepAlive\s+.*/TCPKeepAlive yes/' /etc/ssh/sshd_config \
    && sed -ri 's/^#?#ClientAliveInterval\s+.*/#ClientAliveInterval 300/' /etc/ssh/sshd_config \
    && sed -ri 's/^#?X11UseLocalhost\s+.*/X11UseLocalhost no/' /etc/ssh/sshd_config

# expose ssh port
EXPOSE 22

# start sshd deamon
ENTRYPOINT ["/usr/sbin/sshd","-D"]
