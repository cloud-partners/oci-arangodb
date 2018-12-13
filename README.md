# oci-arangodb

![oci-arangodb](https://www.arangodb.com/wp-content/uploads/2016/05/ArangoDB_logo_@3.png "ArangoDB logo")

Terraform module for deploying a single node ArangoDB instance.
  
## Prerequisites
First off you'll need to do some pre deploy setup.  That's all detailed [here](https://github.com/cloud-partners/oci-prerequisites).

## 1. Clone the repository
Now, you'll want a local copy of this repo. You can make that with the commands:

`git clone https://github.com/cloud-partners/oci-arangodb.git`

## 2. Deploy
You can deploy with the following Terraform commands:

`terraform init`

`terraform plan`

`terraform apply`

When the deployment is completed, it will show you the public IP of the instance created on Oracle Cloud Infrastructure (OCI). Using that public IP, create an SSH tunnel using following command:

`ssh -L 8529:localhost:8529 opc@<public IP of the instance>`

After that, you can simply browse to (http://localhost:8529). Username is `root` and the password is `ARANGODBONOCI`.

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy
