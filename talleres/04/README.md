# Rolling Update de ASG usando CloudFormation.

Explorar las políticas de actualización de CloudFormation para Auto Scaling Groups.

## Instrucciones

1. **Template**

Revisa el archivo [rolling.yaml](./rolling.yaml) que contiene los recursos para servir el API de Mythical Mysfits con ASG.

2. **Creation Policy**

El script de `UserData` del recurso `LaunchConfiguration` contiene una línea de código para notificar a CloudFormation cuando la instalación del API se hizo correctamente:

```bash
/opt/aws/bin/cfn-signal -e 0 --region ${AWS::Region} --stack ${AWS::StackName} --resource AutoScalingGroup
```

Revisa la documentación de CloudFormation sobre [CreationPolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html) y configura la propiedad `ResourceSignal` para esperar las señales del `UserData` antes de continuar la creación del stack.

3. **Update Policy**

Revisa la documentación de [UpdatePolicy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-updatepolicy.html) y configura un despliegue de tipo `AutoScalingRollingUpdate` para el stack.

4. **Creación del stack**

Para crear el stack utiliza el siguiente comando:

```bash
aws cloudformation create-stack --stack-name rolling --template-body file://rolling.yaml
```

Verifica que los servidores notifican a CloudFormation sobre la ejecución exitosa de `UserData`.

5. **Actualización del stack**

Modifica el user data para ejecutar la versión 2 del API:

```bash
nohup gunicorn -w 3 -b 0.0.0.0:8000 app-v2:app &
```

Y lanza una actualización del stack con el siguiente comando:

```bash
aws cloudformation update-stack --stack-name rolling --template-body file://rolling.yaml
```

## Validación

La creación del stack debe mostrar en la pestaña de `Events` de Cloudformation eventos sobre las señales recibidas por parte de los servidores y el `UserData`.

Al actualizar el stack primero se reduce el número de servidores sin llegar a 0. Inmediatamente, CloudFormation crea los nuevos servidores con la versión 2 del API, y al recibir las señales de `cfn-signal`, considera los servidores como saludables y termina las instancias restantes con la versión 1 del API. Todo esto se puede ver en la pestaña `Events` del stack de CloudFormation.

## Limpieza

Eliminar el stack con el siguiente comando:

```bash
aws cloudformation delete-stack --stack-name rolling
```