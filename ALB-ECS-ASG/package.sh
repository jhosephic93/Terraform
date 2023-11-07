id_account="<your-aws-id-account>"
name_repository="demo-dev-my-repository"
version="v1"
region="<region>"
profile="<your-profile>"
cd Terraform
pwd
ls -al
echo "#------------------------------------------------------------------------------"
echo "# CREATING AWS ECR"
echo "#------------------------------------------------------------------------------"
terraform init
terraform apply -target=module.ecr -auto-approve
echo "#------------------------------------------------------------------------------"
echo "# BUILD CONTAINER IMAGE IN LOCAL"
echo "#------------------------------------------------------------------------------"
cd ../flask-python3
ls -la
aws ecr get-login-password --region $region --profile $profile | docker login --username AWS --password-stdin 389263978163.dkr.ecr.us-east-1.amazonaws.com
docker build -t $id_account.dkr.ecr.$region.amazonaws.com/$name_repository:$version .
docker push $id_account.dkr.ecr.$region.amazonaws.com/$name_repository:$version
docker images
echo "#------------------------------------------------------------------------------"
echo "# CREATING INFRA"
echo "#------------------------------------------------------------------------------"
cd ../Terraform
terraform init
terraform apply -auto-approve