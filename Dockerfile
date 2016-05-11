FROM alpine:latest

RUN apk update 
RUN apk add git openssh 
#RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config 
#RUN adduser -S git 
#RUN mkdir -p /home/git/.ssh 
#RUN /usr/bin/ssh-keygen -A

EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"]
