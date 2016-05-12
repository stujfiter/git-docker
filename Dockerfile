FROM alpine:latest

RUN apk update
RUN apk add git openssh
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication no/" /etc/ssh/sshd_config
RUN addgroup git
RUN adduser -s /usr/bin/git-shell -D -G git git
RUN mkdir -p /home/git/.ssh
RUN mkdir -p /home/git/repo/sources.git
RUN echo '' >> /home/git/.ssh/authorized_keys
WORKDIR /home/git/repo/sources.git
RUN git init --bare
RUN chown -R git:git /home/git
RUN /usr/bin/ssh-keygen -A
RUN passwd -u git

EXPOSE 22

#CMD ["/usr/sbin/sshd", "-D"]
