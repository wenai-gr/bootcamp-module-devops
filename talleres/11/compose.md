# Docker compose

1. Instalar docker-compose:

```bash
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

2. Crear el archivo `Dockerfile` en la carpeta `backend/`:

```Dockerfile
FROM python:3.7-alpine

EXPOSE 8000

WORKDIR /opt/app

COPY . .

RUN pip install -r requirements.txt

ENTRYPOINT ["gunicorn", "-w", "3", "-b", "0.0.0.0:8000", "app:app"]
```

3. Crear el archivo `Dockerfile` en la carpeta `frontend/`:

```Dockerfile
FROM nginx

EXPOSE 80

COPY index.html /usr/share/nginx/html/
```

4. Crear el archivo `docker-compose.yml` en la carpeta raíz del proyecto:

```yaml
version: '3'
services:
  web:
    build: frontend/.
    ports:
      - "80:80"
  api:
    build: backend/.
    ports:
      - "8000:8000"
```

5. Desde la carpeta raíz prueba los siguientes comandos:

```bash
docker-compose build
```

```bash
docker-compose up
```

```bash
docker-compose down
```