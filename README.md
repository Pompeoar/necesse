# Deploy Necesse to ACI
## About this repo
This repo uses Github Actions to run a yml that deploys azure infrastructure via bicep files that ultimately result in a necesse container image running in ACI with a separate storage mounted for persistent data. The steps provided are intended to assist in replicating that exact layout. 

Let's begin.

## Things you'll need
1. An Azure Subscription
2. A Github Account

## Create a service principle
Github Actions need a way to speak to Azure. We're going to provide a service principle.
1. Get your subscription ID
    1. Head to Azure Portal and copy it or
    2. run ```az account show``` in powershell while logged into your azure account
2. Create a service principle
    1. Run ``` az ad sp create-for-rbac --name GithubActions --role Contributor --scopes /subscriptions/<yourSubscriptionId> --sdk-auth```
        2. If you're having trouble logging in, try running ```az login --use-device-code``` to authorize that session
    2. Copy the entire json response
    3. Head to your Repo -> Settings -> Security -> Secrets -> Actions
    4. Click ```New Repositiory Secret``` 
    5. Give it a name (ex: AZURE_CREDENTIALS)
    6. Paste the json as the value ex:
         ```
        {
            "clientId": "<GUID>",
            "clientSecret": "<GUID>",
            "subscriptionId": "<GUID>",
            "tenantId": "<GUID>",
            "activeDirectoryEndpointUrl": "https://login.microsoftonline.com",
            "resourceManagerEndpointUrl": "https://management.azure.com/",
            "activeDirectoryGraphResourceId": "https://graph.windows.net/",
            "sqlManagementEndpointUrl": "https://management.core.windows.net:<PORT>/",
            "galleryEndpointUrl": "https://gallery.azure.com/",
            "managementEndpointUrl": "https://management.core.windows.net/"
        }
    
