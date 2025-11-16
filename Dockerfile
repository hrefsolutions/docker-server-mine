FROM debian:stable-slim

# Dependencias básicas
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    nodejs \
    npm \
    supervisor \
    ca-certificates \
    && apt-get clean

WORKDIR /app

# Crear carpetas equivalentes al compose
RUN mkdir -p /app/data /app/servers /app/filebrowser-data

# ---------------------------
# INSTALAR MINEPANEL
# ---------------------------
RUN curl -L https://github.com/ketbom/MinePanel/releases/latest/download/minepanel-linux-amd64.tar.gz \
    -o minepanel.tar.gz && \
    tar -xzf minepanel.tar.gz && \
    rm minepanel.tar.gz && \
    mv minepanel /usr/local/bin/minepanel

# ---------------------------
# INSTALAR FILEBROWSER
# ---------------------------
RUN curl -fsSL https://github.com/filebrowser/filebrowser/releases/latest/download/linux-amd64-filebrowser.tar.gz \
    | tar -xz && \
    mv filebrowser /usr/local/bin/filebrowser

# Copiar entrypoint
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

EXPOSE 8091
EXPOSE 3000
EXPOSE 8080

CMD ["/app/entrypoint.sh"]
