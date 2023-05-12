#Indicam la versio d'ubuntu per al Dockerfile.
FROM ubuntu:20.04

#Feim un Update i despres instalem el servei de DLNA.
RUN apt-get update
RUN apt-get install  minidlna -y

#Copiam l'arxiu de configuració del servei DLNA adins del contenidor.
COPY minidlna.conf /etc/minidlna.conf

#Copiam el video adins del directori arrel del servidor DLNA.
COPY video.mp4 /var/lib/minidlna/

#Feim que el directori /var/lib/minidlna tingui els permisos necessaris per al servidor DLNA.
RUN chown -R minidlna:minidlna /var/lib/minidlna && chmod -R 777 /var/lib/minidlna

#Exposem el port 8200 del contenidor per accedir al servidor DLNA.
EXPOSE 8200
EXPOSE 554

#Executem el servidor DLNA al iniciar el contenidor.
CMD ["sh", "-c", "service minidlna start && tail -f /var/log/minidlna.log"]
