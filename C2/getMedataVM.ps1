function Get-AccesTokenFromServicePrincipal {
    param(
        [string] $TenantID,
        [string] $ClientID,
        [string] $ClientSecret
    )
 
    $TokenEndpoint = 'https://login.windows.net/{0}/oauth2/token' -f $TenantID
    $ARMResource = 'https://management.core.windows.net/'
 
    $Body = @{
        'resource'      = $ARMResource
        'client_id'     = $ClientID
        'grant_type'    = 'client_credentials'
        'client_secret' = $ClientSecret
    }
    $params = @{
        ContentType = 'application/x-www-form-urlencoded'
        Headers     = @{'accept' = 'application/json' }
        Body        = $Body
        Method      = 'Post'
        URI         = $TokenEndpoint
    }
    $token = Invoke-RestMethod @params
    ('Bearer ' + ($token.access_token).ToString())
}
 
 
$AuthorizationToken = Get-AccesTokenFromServicePrincipal `
    -TenantID '7d1dfe7b-898f-47ea-80a6-888b3643e2fb' `
    -ClientID '54d453e0-f59f-4f22-a24b-1e17f6b8e727' `
    -ClientSecret '*****************'


# $AuthorizationToken

# Function to get the metadata of VM
function Get-MetadaVM {
    param
    (
        [Parameter(Mandatory=$true)]
        $AzureSubscriptionID,
        $ResourceGroupName,
        $VmName
    )
    $url = "https://management.azure.com/subscriptions/"+$AzureSubscriptionID+"/resourceGroups/"+ $ResourceGroupName+"/providers/Microsoft.Compute/virtualMachines/"+$VmName+"?api-version=2021-07-01"
    $results = Invoke-RestMethod -Uri $url -Method Get -ContentType "application/json" -Headers @{Authorization = $AuthorizationToken}
    return $results
}

$MetadataResult = Get-MetadaVM -AzureSubscriptionID 91ae95ad-948c-49c0-8b3b-98837ff7a055 -ResourceGroupName challenge1-3tier-azure -VmName web-vm


$MetadataResult | ConvertTo-Json