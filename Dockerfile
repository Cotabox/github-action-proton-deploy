FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install curl unzip gnupg software-properties-common wget

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.2.13.zip" -o "awscliv2.zip"
RUN unzip -q awscliv2.zip
RUN sh /aws/install

RUN aws --version

RUN apt-get -y install jq

RUN echo 'f6bd1536a743ab170b35c94ed4c7c4479763356bd543af5d391122f4af852460  yq_linux_amd64' > yq_linux_amd64.sha
RUN wget https://github.com/mikefarah/yq/releases/download/3.4.0/yq_linux_amd64
RUN sha256sum -c yq_linux_amd64.sha
RUN mv yq_linux_amd64 /usr/bin/yq
RUN chmod +x /usr/bin/yq

ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
