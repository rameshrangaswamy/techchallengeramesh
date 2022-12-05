#### Function to retrieve value from input object and key ####
function Get-ValueObjectkey
{
    param (
        [Parameter(Mandatory = $True)][string]$inputObject,
        [Parameter(Mandatory = $True)][string]$inputKey
    )

    $inputkeys = $inputKey -split "/"

    $jsonObject = $inputObject | ConvertFrom-Json

    foreach ($ikey in $inputkeys)
    {
        # Write-Host "ikey :: $ikey"
        $out_value = $jsonObject.$ikey
        # Write-Host "out_value :: $out_value"
        $jsonObject = $out_value
    }

    Write-Output "Value : $out_value"
}
<#
$inputObject = '{"a":{"b":{"c":"d"}}}'
$inputKey = "a/b/c"
Get-ValueObjectkey $inputObject $inputKey

$inputObject = '{"x":{"y":{"z":"a"}}}'
$inputKey = "x/y/z"
Get-ValueObjectkey $inputObject $inputKey

$inputObject = '{"share":{"users":{"name":"Ramesh"}}}'
$inputKey = "share/users/name"
Get-ValueObjectkey $inputObject $inputKey
#>