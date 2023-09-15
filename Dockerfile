FROM gilleslamiral/imapsync
WORKDIR /codeinloop/
COPY lista.txt /codeinloop/
COPY app.sh /codeinloop/
ENTRYPOINT ["sh", "./app.sh"]
