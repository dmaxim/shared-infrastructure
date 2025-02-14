# Install

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/stable/manifests/install.yaml


# Create a secret with the GitHub token
kubectl -n argocd create secret generic git-creds \
  --from-literal=username=<git-hub-user-name> \
  --from-literal=password=<git-hub-token> \
  --from-literal=git-token=<private-ssh-key>


  # Add annotations to argocd application


kubectl patch application --type=merge -n argocd vote-staging --patch-file vote-patch.yaml