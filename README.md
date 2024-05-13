# shared-infrastructure

## Argo Install Via Kustomize

```
cd argo/manifests
kustomize build . | kubectl apply -f -
```

NOTE: The manifests are for a 3 node HA ArgoCD cluster. It requires a minimum of 4 nodes in the cluster due to node affinitiy rules.

### Chage Argo Password

```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
kubectl port-forward -n argocd svc/argocd-server 8080:80
argocd login localhost:8080
argocd account update-password
```

## Setup Argo App

```
kubectl apply -f argo/argocd-app.yaml

kubectl rollout restart -n argocd deployment argocd-repo-server

```
