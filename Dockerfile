FROM alpine:latest

RUN apk update
RUN apk add git openssh

#RUN /etc/init.d/sshd start
RUN ssh-keygen -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -N '' -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -N '' -f /etc/ssh/ssh_host_ed25519_key

RUN adduser -D git
RUN echo "git:git001" | chpasswd

RUN mkdir /home/git/project.git
WORKDIR /home/git/project.git
RUN git init --bare
RUN chown -R git:git /home/git/project.git
 
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
