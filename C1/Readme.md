Connect-AzAccount -TenantId 7d1dfe7b-898f-47ea-80a6-888b3643e2fb
Set-AzContext -Subscription 91ae95ad-948c-49c0-8b3b-98837ff7a055
$sp = New-AzADServicePrincipal -DisplayName testchallengesp -Role "Contributor"
$sp.AppId
$sp.PasswordCredentials.SecretText

$env:ARM_CLIENT_ID="54d453e0-f59f-4f22-a24b-1e17f6b8e727"
$env:ARM_SUBSCRIPTION_ID="91ae95ad-948c-49c0-8b3b-98837ff7a055"
$env:ARM_TENANT_ID="7d1dfe7b-898f-47ea-80a6-888b3643e2fb"
$env:ARM_CLIENT_SECRET="**************"
$env:ARM_ACCESS_KEY="**************"

gci env:ARM_*

terraform init
terraform validate
terraform plan -out main.tfplan
terraform apply main.tfplan
terraform plan -destroy -out main.destroy.tfplan
terraform apply main.destroy.tfplan