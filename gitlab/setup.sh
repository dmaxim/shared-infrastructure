
helm repo add gitlab https://charts.gitlab.io
helm repo update

helm search repo -l gitlab/gitlab --versions

helm install gitlab-runner gitlab/gitlab-runner \
  --namespace mxinfo-gitlab \
  --values=./values.yaml




helm install gitlab-runner gitlab/gitlab-runner \
  --namespace gitlab-runner \
  --version=0.80.0 \
  --values=./values.yaml

  helm upgrade gitlab-runner \
        --set gitlabUrl=https://gitlab.com,runnerRegistrationToken=<token>\
        --namespace gitlab-runner \
        gitlab/gitlab-runner