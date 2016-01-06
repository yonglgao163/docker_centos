FROM        centos:6.7
MAINTAINER  rongtian "rongtian@taobao.com"
 
RUN         yum install -y openssh openssh-server openssh-clients
RUN         mkdir -p /var/run/sshd
RUN         ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN         ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN         /bin/echo 'root:123456' |chpasswd
RUN         useradd admin
RUN         /bin/echo 'admin:123456' |chpasswd
RUN         /bin/sed -i 's/.*session.*required.*pam_loginuid.so.*/session optional pam_loginuid.so/g' /etc/pam.d/sshd
RUN         /bin/echo -e "LANG=\"en_US.UTF-8\"" > /etc/default/local

ADD 	    jdk1.6.0_45 /opt/install/jdk1.6.0_45
ADD 	    tomcat /opt/install/tomcat 
ADD 	    profile /etc/profile

RUN	    yum install -y python-setuptools
RUN	    easy_install supervisor

ADD	    supervisor /etc/supervisor
ADD	    run.sh /home/admin/bin/run.sh
