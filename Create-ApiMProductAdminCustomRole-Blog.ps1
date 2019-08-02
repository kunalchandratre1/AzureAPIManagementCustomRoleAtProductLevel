

Login-AzAccount
Get-AzRoleDefinition -Name "API Management Service Reader Role" | ConvertTo-Json | Out-File "Your local path of choice\APIMProductAdminCustomRole.json"

#get the id of product in API Management
$apimContext = New-AzApiManagementContext -ResourceGroupName "YourResource Group name under which API Management instance is present" -ServiceName "API Management service instance name"
Get-AzApiManagementProduct -Context $apimContext -Title HR


#to create new role for the first time
New-AzRoleDefinition -InputFile "Your local path of choice\APIMProductAdminCustomRole.json"
#this adds the Id automatically to role definition

#to retrive role definition ID in powershell object
$role = Get-AzRoleDefinition "API Management Service Product Admin - HR/ Or name suitable to your requirement."
$role


#record Id and add to json file

#to update role for subsequent times
Set-AzRoleDefinition -InputFile "Your local path of choice\APIMProductAdminCustomRole.json"


#product specific scope level role will not be visible in the UI therefore assign using powershell - 
Get-AzADUser -StartsWith "Your User name - can be Microsoft account or your Azure AD account"

#record the Id of the output - b17e7e40-2c99-47ff-a5e9-a23f0505ef6e

#get api management id to grant access to user
$apim = Get-AzApiManagement -ResourceGroupName "YourResourceGroupName" -Name "YourAPI Management name"
$apim.Id




#assign role at resource scope level means at API Management level directly
New-AzRoleAssignment -ObjectId "Object Id of your user" -RoleDefinitionName "Reader" -ResourceName "Your API Management namne" -ResourceType Microsoft.ApiManagement/service -ResourceGroupName "Your Resource group name"
New-AzRoleAssignment  -SignInName "SignIn Name or UPN of your user" -RoleDefinitionName "API Management Service Product Admin - HR/ or name of your custom role from JSON" -Scope "completed Id of the product. Sample here - /subscriptions/SubscriptionId/resourceGroups/ResourceGroupName/providers/Microsoft.ApiManagement/service/API Management Name/products/ProductsName"

#to check level of access for a user on API Management use below powershell - custom roles will not be visible on the portal
Get-AzRoleAssignment -ObjectId "Object Id of your user"

