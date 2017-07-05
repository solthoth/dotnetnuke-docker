FROM microsoft/iis
MAINTAINER github.com/solthoth

ADD https://github.com/dnnsoftware/Dnn.Platform/releases/download/v9.1.0/DNN_Platform_9.1.0.367_Install.zip /DotNetNuke.zip
ADD . /

RUN powershell -NoProfile -File  C:\setup.ps1

EXPOSE 3000