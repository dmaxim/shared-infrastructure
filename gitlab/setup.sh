
helm repo add gitlab https://charts.gitlab.io
helm repo update

helm search repo -l gitlab/gitlab

helm install gitlab-runner gitlab/gitlab-runner \
  --namespace mxinfo-gitlab \
  --values=./values.yaml


