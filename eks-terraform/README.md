Create S3 Bucket
aws s3api create-bucket --bucket <bucket-name> --region <region> --create-bucket-configuration LocationConstraint=ap-south-1

Enable Versioning
aws s3api put-bucket-versioning --bucket <bucket-name> --versioning-configuration Status=Enabled

Enable Encryption
aws s3api put-bucket-encryption --bucket <bucket-name> --server-side-encryption-configuration "{\"Rules\":[{\"ApplyServerSideEncryptionByDefault\":{\"SSEAlgorithm\":\"AES256\"}}]}"

Block Public Access on S3 Bucket
aws s3api put-public-access-block --bucket <bucket-name> --public-access-block-configuration BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true


Create DynamoDB Table
aws dynamodb create-table --table-name terraform-state-lock --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --region <region>



To get kubectl access

1. Verify AWS CLI Identity
aws sts get-caller-identity

Make sure this is the IAM user or role that should access the cluster.

2. Update kubeconfig
aws eks update-kubeconfig --region <region> --name <cluster-name>


3. Verify Context
kubectl config get-contexts

Current context:

kubectl config current-context

dummy commit
2

