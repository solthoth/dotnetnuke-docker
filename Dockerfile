# escape=`
FROM microsoft/iis
MAINTAINER github.com/solthoth

ADD setup.ps1 /setup.ps1

RUN powershell -NoProfile -File  C:\setup.ps1

EXPOSE 3000