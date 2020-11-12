# Desplegando la API usando CloudFormation y Auto Scaling Groups

Completar la plantilla de CloudFormation para desplegar el API de Mythical Mysfits

## Instrucciones

1. **Plantilla de CloudFormation**

Revisa el archivo [api-asg.yaml](./api-asg.yaml) que contiene el esqueleto para crear los recursos necesarios:

- Security Groups para instancias y load balancer
- Load Balancer (Classic)
- Launch Configuration
- Auto Scaling Group

2. **Security Groups**

Agregar las reglas para ambos security groups:

- *Load Balancer:* Debe permitir el tráfico entrante en el puerto **80** desde cualquier fuente.

- *Instancias:* Aceptar tráfico entrante en el puerto **8000** desde el security group del Load Balancer. Aceptar tráfico entrante en el puerto **22** desde cualquier fuente.

Consulta la documentación de CloudFormation sobre [Security Groups](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html). **Tip**: Revisa la propiedad [SecurityGroupIngress](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-security-group.html#cfn-ec2-securitygroup-securitygroupingress) para completar este paso.

3. **Load Balancer**

Agregar las propiedades [Listener](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html#cfn-ec2-elb-listeners) y [HealthCheck](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-ec2-elb.html#cfn-ec2-elb-healthcheck). El Load Balancer debe escuchar en el puerto 80 y dirigir el tráfico al puerto 8000 de las instancias.

4. **Launch Configuration**

Agregar el script de [UserData](https://docs.aws.amazon.com/es_es/AWSCloudFormation/latest/UserGuide/aws-properties-as-launchconfig.html#cfn-as-launchconfig-userdata) con los comandos necesarios para instalar y ejecutar el API de Mythical Mysfits.

5. **Auto Scaling Group**

Agregar el recurso [AutoScalingGroup](https://docs.aws.amazon.com/es_es/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html) con propiedades para vincular el Launch Configuration y Load Balancer.

6. Crear el stack de CloudFormation:

```bash
aws cloudformation create-stack --stack-name api-asg --template-body file://api-asg.yaml
```

Si es necesario actualizar, ocupar el siguiente comando:

```bash
aws cloudformation update-stack --stack-name api-asg --template-body file://api-asg.yaml
```

## Validación

Obtener la URL del Load Balancer y validar que la API responde correctamente. Aumentar el número de instancias y eliminar servidores para validar el funcionamiento de Auto Scaling Groups.

## Limpieza

Eliminar el stack con el siguiente comando:

```bash
aws cloudformation delete-stack --stack-name api-asg
```