# Desplegando la API de Mythical Mysfits usando Auto Scaling Groups

Usar Launch Configuration, Auto Scaling Group y un Load Balancer para desplegar el API de Mythical Mysfits.

## Instrucciones

1. **Load Balancer**

Crear un Classic Load Balancer para distribuir la carga entre las instancias del ASG.

2. **Launch Configuration**

Define un nuevo Launch Configuration con servidores `t2.micro` y `Amazon Linux 2`. 

Debes crear un script y ocuparlo en el User Data para poder hacer bootstraping de las instancias con el código del API en ejecución ocupando `gunicorn`. Puedes ocupar como ejemplo el script proporcionado en [user-data.sh](./user-data.sh).

3. **Auto Scaling Group**

Utiliza el Launch Configuration creado anteriormente, despliega 2 instancias EC2 con la API desplegada y define el Load Balancer como punto de entrada para los usuarios.

## Validación

De la forma que prefieras, muestra el contenido de `frontend/index.html` con la URL del Load Balancer configurada y valida que la aplicación sigue funcionando correctamente.

Termina una instancia y corrobora que no hay perdida de servicio gracias a la alta disponibilidad que ofrece el ASG.

## Limpieza

Borrar el Auto Scaling Group, Launch Configuration y Load Balancer, así como los grupos de seguridad que hayan sido creados.