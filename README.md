# Bootcamp DevOps

Este ejercicio está basado en la aplicación del workshop [Mythical Mysfits](https://github.com/aws-samples/aws-modern-application-workshop) de AWS.

El objetivo es aprender, de forma incremental, el ciclo de vida de una aplicación así como demostrar los diferentes servicios de AWS que podemos ocupar para desplegar, automatizar y monitorear una aplicación.

## Instrucciones

Hacer **Fork** de este repositorio en tu cuenta de GitHub.

Elige la región de AWS que ocuparás durante el curso: Virginia (us-east-1), Ohio (us-east-2) u Oregon (us-west-2) y crea un **Key Pair** en la consola de EC2 que lleve por nombre `mythical-mysfits`.

Después de clonar el repositorio, agrega un `remote` para mantener tu copia actualizada:

```bash
git remote add upstream https://github.com/eloyvega/bootcamp-module-devops.git
```

Ejecuta los siguientes comandos cada vez que necesites actualizar tu repositorio:

```bash
git fetch upstream
git checkout master
git merge upstream/master
git push origin master
```

Sigue las instrucciones de cada [taller](./talleres).