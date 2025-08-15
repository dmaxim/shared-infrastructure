

# Lookup OIDC issuer

````

az aks show --name <aks-cluster-name> --resource-group <resource-group-name> --query oidcIssuerProfile.issuerUrl -o tsv

````



## Next steps
- Create external secret provider with service account / workload identity?
- Create external secret to store pact creds - verify secrets are loaded