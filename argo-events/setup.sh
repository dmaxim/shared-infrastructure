
k create namespace argo-events

k apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/install.yaml

k apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml -n argo-events


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
