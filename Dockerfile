# Gunakan base image yang tersedia
FROM consol/ubuntu-xfce-vnc:latest

# Setel variabel lingkungan untuk resolusi layar
ENV RESOLUTION 1707x1067

# Ekspos port yang digunakan VNC (80 di dalam container)
EXPOSE 80

# Buat skrip untuk menjalankan VNC dan Supervisor
RUN echo 'supervisord -c /etc/supervisor/supervisord.conf' >> /docker.sh \
    && chmod 755 /docker.sh

# Jalankan VNC menggunakan Supervisor
CMD /bin/bash /docker.sh
