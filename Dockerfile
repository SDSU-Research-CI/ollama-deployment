FROM ollama/ollama:0.3.10

RUN apt-get update -y \
 && apt-get install -y \
    systemctl \
    vim \
    wget \
    curl

RUN useradd -r -s /bin/false -m -d /usr/share/ollama ollama

RUN echo "[Unit]\nDescription=Ollama Service\n\nAfter=network-online.target\n\n[Service]\nExecStart=/usr/bin/ollama serve\nUser=ollama\nGroup=ollama\nRestart=always\nRestartSec=3\n\n[Install]\nWantedBy=default.target" \
    > /etc/systemd/system/ollama.service

RUN systemctl daemon-reload

USER ollama

ENV OLLAMA_KEEP_ALIVE=-1

USER root
