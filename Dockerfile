# escape=`
FROM microsoft/iis
MAINTAINER github.com/solthoth

ADD DNN_Platform_9.1.0.367_Install.zip /DotNetNuke.zip
ADD setup.ps1 /setup.ps1

RUN powershell -NoProfile -File  C:\setup.ps1

EXPOSE 3000