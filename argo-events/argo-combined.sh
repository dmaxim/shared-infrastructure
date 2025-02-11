

# Actions from demo/argo-events-demo
# Install ArgoCD
kustomize build argo-cd/overlays/production | k apply --filename - 

k --namespace argocd rollout status deployment argocd-server


# Clean up

kustomize build argo-cd/overlays/production | k delete --filename - 


# Updated ingress and server yaml to use personal DNS and not use the server deployment patch as it is broken


k apply -f project.yaml

k apply -f apps.yaml