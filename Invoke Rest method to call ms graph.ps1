#https://www.youtube.com/watch?v=EBm2K0pOqwQ => not that great

#https://www.youtube.com/watch?v=czhGnlNiHDA => this is good

#https://www.youtube.com/watch?v=3dWZNfiyo_g => this is also good

#https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-restmethod?view=powershell-7.2

#Set up the authentication configuration

$clientId = ""
$tenantName = ""
$clientSecret = ""

$RequestTokenBody = @{
    Grant_Type = "client_credentials"
    Scope = "https://graph.microsoft.com/.default" #use the tokens granted on the app registration
    client_Id = $clientId
    Client_Secret = $clientSecret
}

$TokenResponce = Invoke-RestMethod -Uri "https://login/microsoftonline.com/$tenantName/oauth2/v2.0/token" -Method Post -Body $RequestTokenBody

$TokenResponce

#Make the request to Ms Graph

$request = @{
    Method = "Get"
    Uri = "https://graph.microsoft.com/v1.0/users"
    ContentType = "application/json"
    Headers = @{Authorization = "Bearer $($Tokenresponce.access_token)"}
}

$myData = Invoke-RestMethod @request


# To make a Post request ot Ms Graph

$CreateUserBody = @"
{
    "accountEnabled": "true",
    "displayName": "New User",
    "userPrincipalName": "newUser@microsoftonline.com"
}
"@

#!note the @" "@ needs to be on different lines

$userBody = @"
{
  "accountEnabled": true,
  "displayName": "Philippa Eilhart",
  "mailNickname": "pEilhart",
  "userPrincipalName": "peilhart@contoso.HugoTennant.onmicrosoft.com",
  "passwordProfile" : {
    "forceChangePasswordNextSignIn": true,
    "password": "xWwvJ]6NMw+bWH-d"
  }
}
"@

$request = @{
    Method = "Post"
    Uri = "https://graph.microsoft.com/v1.0/users"
    ContentType = "application/json"
    Headers = @{Authorization = "Bearer $($TokenResponce.access_token)"}
    Body = $userBody
}

$user = Invoke-RestMethod @request


#look into invoke web request
