# 01-TERRAFORM-CT01
try { . "c:\Users\Portatil\AppData\Local\Programs\Microsoft VS Code\7debcd0e2a\resources\app\out\vs\workbench...
   2 mkdir terraform-01-ec2                                                                                          
   3 cd terraform-01-ec2                                                                                             
   4 New-Item Main.tf                                                                                                
   5 cd ..                                                                                                           
   6 $env:AWS_ACCESS_KEY_ID="ASIA3OZBUG5HS6K4KG2P"...                                                                
   7 aws sts get-caller-identity --region us-east-1                                                                  
   8 cd ..                                                                                                           
   9 cd .\terraform-01-ec2\                                                                                          
  10 echo "# 01-TERRAFORM-CT01" >> EVIDENCIAS.md                                                                     
  11 terraform init                                                                                                  
  12 terraform init                                                                                                  
  13 terraform plan                                                                                                  
  14 terraform apply                                                                                                 
  15 terraform destroy
