FROM centos
COPY . .
RUN yum update -y && yum install -y ant make openssh-server sudo initscripts
RUN useradd nso && echo "root:P@ssw0rd" | chpasswd && echo "nso:P@ssw0rd" | chpasswd && chmod +x nso-5.2.1.linux.x86_64.installer.bin && mkdir /var/run/sshd && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key 
RUN ./nso-5.2.1.linux.x86_64.installer.bin --system-install && mv ncs.conf /etc/ncs/ncs.conf && groupadd ncsadmin && usermod -a -G ncsadmin nso && source /etc/profile.d/ncs.sh 
CMD /etc/init.d/ncs start ; /usr/sbin/sshd -D
EXPOSE 8080 22


