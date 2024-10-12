# Gunakan base image yang tersedia di Docker Hub
FROM consol/ubuntu-xfce-vnc:latest

# Setel variabel lingkungan untuk resolusi layar dan ngrok
ENV RESOLUTION 1707x1067 \
    NGROK_TOKEN=2a9RsNJrnIxs9LENpCHrpjHkC81_2Xk1uHjRqVztD37cJtuAf

# Ekspos port yang digunakan VNC (80 di dalam container)
EXPOSE 80

# Install ngrok
RUN apt-get update && \
    apt-get install -y curl wget unzip && \
    wget -O ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.zip && \
    unzip ngrok.zip && \
    rm ngrok.zip

# Buat skrip untuk menjalankan ngrok dan VNC
RUN echo "/ngrok http 80 --authtoken ${NGROK_TOKEN} &" >> /docker.sh \
    && echo "sleep 5" >> /docker.sh \
    && echo "curl -s http://localhost:4040/api/tunnels | python3 -c \"import sys, json; print(\\\"Access VNC via:\\\", json.load(sys.stdin)['tunnels'][0]['public_url'])\" || echo \"Error: NGROK_TOKEN, reset token ngrok dan coba lagi\"" >> /docker.sh \
    && echo 'supervisord -c /etc/supervisor/supervisord.conf' >> /docker.sh \
    && chmod 755 /docker.sh

# Jalankan ngrok dan VNC
CMD /bin/bash /docker.sh
