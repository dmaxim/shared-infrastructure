# shared-infrastructure

## Argo Install Via Kustomize

```
cd argo
kustomize build . | kubectl apply -f -
```

### Chage Argo Password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward -n argocd svc/argocd-server 8080:80
argocd login localhost:8080
argocd account update-password
```

ym8KehNhe55BqLez
