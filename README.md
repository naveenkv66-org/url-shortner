# url-shortner

A sample project to deploy a URL shortener backend using **Azure App Service** and optionally **Redis Cache**, all provisioned via **Infrastructure as Code (IaC)** using **Bicep**.

---

## 🧱 Infrastructure as Code (IaC)

This project uses [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview) to define and deploy Azure resources like:

- App Service Plan (Linux, B1 tier)
- Web App (running .NET 8)
- (Optional) Redis Cache (to be added)

---

## 🚀 Deploy to Azure

Make sure [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) is installed.

### ✅ Steps to deploy:

```bash
# Log in to Azure
az login

# Create a resource group and deploy the Bicep template
az group create --name learning-urlshortner-dev --location southeastasia

az deployment group create --resource-group learning-urlshortner-dev --template-file Infrastructure/main.bicep

#To delete everything after testing:
az group delete --name learning-urlshortner-dev --yes --no-wait

```


### Create User for GH Actions

```bash
az ad sp create-for-rbac --name "GitHub-Actions-SP" --role contributor  --scopes /subscriptions/67a63877-9ecd-4d2a-b2c2-7cf4047395bb --sdk-auth
```
### Apply to Custom Contributor Role

```bash
az ad sp create-for-rbac --name "GitHub-Actions-SP" --role infra_deploy  --scopes /subscriptions/67a63877-9ecd-4d2a-b2c2-7cf4047395bb --sdk-auth
```

### Configure federated identity credential in app (Azure)