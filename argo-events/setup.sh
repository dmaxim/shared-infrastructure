
k create namespace argo-events

k apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml

k apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install-validating-webhook.yaml -n argo-events

k apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml -n argo-events

# Create RBAC - allow argo events to laugh workflows
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/master/examples/rbac/sensor-rbac.yaml -n argo-events

kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/master/examples/rbac/workflow-rbac.yaml -n argo-events

## local RBAC Files
k apply -f rbac/sensor-rbac.yaml -n argo-events
k apply -f rbac/workflow-rbac.yaml -n argo-events

# Event Bus - Bridge between event sources and triggers

# Creae webhook eventSource

k apply -f event-source.yaml -n argo-events

k -n argo-events get eventsource

k port-forward svc/webhook-eventsource-svc 12000:12000 -n argo-events

curl -X POST -H "Content-Type: application/json" -d '{"message": "hello"}' http://localhost:12000/devops-toolkit


# Clean up

k delete namespace argo-events

k delete -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml

k delete -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml -n argo-events


# Combined demo

git clone https://github.com/vfarcic/argo-combined-demo.git


# GitHub Token Secret



kubectl create secret generic github-token-secret --from-literal=token=<token> -n argo-events