FROM alpine:latest

#get the necessary applications
RUN apk update
RUN apk add git openssh

#Generate the server keys and turn off password auth
RUN ssh-keygen -A
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config 

#setup git user with no password, unlocked and no authorized keys
RUN adduser -D git
RUN passwd -u git
RUN mkdir /home/git/.ssh
RUN touch /home/git/.ssh/authorized_keys
RUN chown -R git:git /home/git/.ssh

#setup the project directory
RUN mkdir /home/git/project.git
WORKDIR /home/git/project.git
RUN git init --bare
RUN chown -R git:git /home/git/project.git

#expose the ssh port and start sshd 
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
