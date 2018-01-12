
aws_access_key="<your access key>"
aws_secret_key="<your secret key>"
aws_region="eu-central-1"
aws_availability_zone="b"

cluster_name="<your cluster name>"
cluster_type="poc"

# DNS
dns = {
  dns_type = "route53"
  hosted_zone_id="<your hosted zone id>"
  #access_key="<your dns access key>"
  #secret_key="<your dns secret key>"
}

# cluster size
master = {
  count=3
}

worker = {
  count=1
}

etcd_backup={
 storage_type = "s3"
}

addons = {
  dashboard={}
  heapster={}
  nginx-ingress={}
  kube-lego={
    email = "your.name@acme.com"
  }
}

#
# use htpasswd to create password entries
# example here: admin:admin
#
dashboard_creds = <<EOF
admin:$apr1$CrBJQtg9$A.BhwGjZ/Iii6KSO72SWQ0
EOF

aws_kube2iam_roles = [
  { name= "example"
    description= "Allow access to ECR repositories beginning with 'example/', and creation of new repositories"
    policy= <<EOF
{
              "Version": "2012-10-17",
              "Statement": [
                {
                  "Action": "ecr:*",
                  "Effect": "Allow",
                  "Resource": "arn:aws:ecr:eu-central-1:${account_id}:repository/example/*"
                },
                {
                  "Action": [
                    "ecr:GetAuthorizationToken",
                    "ecr:CreateRepository"
                  ],
                  "Effect": "Allow",
                  "Resource": "*"
                }
              ]
}
EOF
  }
]



