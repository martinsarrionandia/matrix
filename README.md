# matrix

Deploy Matrix Homeserver using helm. This example configures a matrix server at matrix.sarrionandia.co.uk

Creates;

 - Matrix Synapse deployment using HELM
 - DNS Entries for server and federation
 - letencrypt ingress cert
 - NetworkPolicy


## Requirements

[Route53](https://aws.amazon.com/route53/) Hosted Zone

[AWS Rancher](https://github.com/martinsarrionandia/aws-rancher)

[EBS Volume](https://docs.aws.amazon.com/cli/latest/reference/ec2/create-volume.html)

[AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[kubectl](https://kubernetes.io/docs/tasks/tools/)

## Instrucions

### Create Volumes

The volume must be in the same AZ as your rancher server. The IAM volume policy requires a Rancher=true Tag. If you chnage the Name tag make sure you update the additional variables.

```bash
aws ec2 create-volume \
    --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=rancher-matrix},{Key=Rancher,Value=True}]' \
    --volume-type gp3 \
    --size 5 \
    --availability-zone eu-west-2a

aws ec2 create-volume \
    --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=rancher-matrix-postgresql},{Key=Rancher,Value=True}]' \
    --volume-type gp3 \
    --size 5 \
    --availability-zone eu-west-2a
```

### Create Secret

Create a registration shared secret and store in AWS secret manager.

```bash
aws secretsmanager create-secret \
    --name matrix \
    --description "Matrix secrets" \
    --secret-string "{\"registrationSharedSecret\":\"$(openssl rand -base64 24)\"}"
```

Take note of the Secret ARN in the output

### Update variables

Edit the variables file [variables.tf](variables.tf)

Change the following values

- matrix-secret-arn

- remote-state-bucket

- main-domain

- matrix-subdomain

### Apply Terrafrom

```bash
terraform apply
```

### Create a user

Registraion is disabled in this deployment.

To create a user, enter the following commands. The examples creates a user called merovingian. Ooh la la!

```
export MATRIXUSER=merovingian
export MATRIXPOD=$(kubectl get pods -n matrix --selector=app.kubernetes.io/component=synapse --no-headers=true -o custom-columns=":metadata.name")

kubectl exec --stdin --tty -n matrix  $MATRIXPOD -- register_new_matrix_user -u $MATRIXUSER -a -c /synapse/config/conf.d/secrets.yaml
```

When prompted set your user password


