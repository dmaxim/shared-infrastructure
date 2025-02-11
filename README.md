# shared-infrastructure

## Argo Install Via Kustomize

```
cd argo/manifests
kustomize build . | kubectl apply -f -
```

NOTE: The manifests are for a 3 node HA ArgoCD cluster. It requires a minimum of 4 nodes in the cluster due to node affinitiy rules.

### Change Argo Password

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

### Argo Backup

```
argocd admin export -n argocd > backup-$(data + "%Y-%m-%d").yaml
```

### Restore Argo Backup

````
argocd admin import -n argocd - < backup-2021-09-14.yaml
```
````

## Prometheus Operator

Do not try to install via ArgoCD and helm chart. ArgoCD alters the instance label that the alertmanager uses to identify the instance. This will cause the alertmanager to not be able to find the instance and will not be able to send alerts.

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack -n monitoring

```

## Install ArgoCD Notifications Manually

```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/release-1.0/manifests/install.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-notifications/release-1.0/catalog/install.yaml

```

## Test a Slack Notification

```
argocd login localhost:8080

# Trigger notification using in-cluster config map and secret
argocd admin notifications template notify custom-slack-template nginx --recipient slack:argo-status



# Render notification render generated notification in console
argocd admin notifications template notify app-sync-succeeded guestbook

```

argocd app create guestbook --repo https://github.com/DadaGore/argocd.git \
 --path guestbook --dest-namespace guestbook \
 --dest-server https://kubernetes.default.svc --directory-recurse \
 --annotations notifications.argoproj.io/subscribe.on-sync-succeeded.slack=argo-status

## Using Tokens in Commands

```
argocd proj role create-token argocd read-sync

argocd app sync <application> --auth-token <token>

```

## Ingress Install

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx -n mxinfo-ingress \
--set controller.service.annotations."service\.beta\.kubernetes\.io/azure-load-balancer-health-probe-request-path"=/healthz \
--set controller.service.externalTrafficPolicy=Local
```

## Manual Cert manager Install

```
helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version v1.14.5 --set installCRDs=true
```

## Install External Secrets

```
helm repo add external-secrets https://charts.external-secrets.io
helm repo update

helm install external-secrets \
   external-secrets/external-secrets \
    -n external-secrets \
    --create-namespace \
   --set installCRDs=true
```

## Install Argo Rollouts

```
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
```

## Create a token to use in CI

```
argocd proj role create-token team ci-role -e 5d

```


## Setup Argo Workflows

Quickstart
````
k create namespace argo
ARGO_WORKFLOWS_VERSION=v3.6.0
kubectl apply -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"

kubectl delete -n argo -f "https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml"

kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.6.0/install.yaml

kubectl delete -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.6.0/install.yaml

k port-forward -n argo svc/argo-server -n argo 2746:2746
````