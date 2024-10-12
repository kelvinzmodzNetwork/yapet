#Expose the port on which NoVNC runs (80 inside the container)

5 EXPOSE 80

Edit

Preview

Code 55% faster with GitHub Copilot

#Use the base inage

FROM fredblgr/ubuntu-novnc:20.04

6

7

#Set the environment variable for screen resolution

ENV RESOLUTION 1707x1067

10 #Start the command to run NoVNC

13 CND supervisord", "c", "/etc/supervisor/supervisord.conf"
