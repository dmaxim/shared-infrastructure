
# Install Demo
helm repo add open-telemetry https://open-telemetry.github.io/opentelemetry-helm-charts

helm install my-otel-demo open-telemetry/opentelemetry-demo

k -n default get pods


# Services

k -n default port-forward svc/my-otel-demo-frontendproxy 8080:8080

# localhost:8080/
# localhost:8080/grafana
# localhost:8080/loadgen
# localhost:8080/jaeger/ui/

# Expose Otel collector

k -n default port-forward svc/my-otel-demo-otelcol 4318:4318

# Install Elastic Stack

#helm repo add elastic https://helm.elastic.co
#helm repo update



# Install an eck-managed Elasticsearch and Kibana using the default values, which deploys the quickstart examples.
#helm install es-kb-quickstart elastic/eck-stack -n elastic-stack --create-namespace

kubectl create -f https://download.elastic.co/downloads/eck/2.14.0/crds.yaml
kubectl apply -f https://download.elastic.co/downloads/eck/2.14.0/operator.yaml

k -n elastic-system logs -f statefulset.apps/elastic-operator

## Deploy elasticsearch cluster

k apply -f elastic.yaml


k get elasticsearch -n elastic-system


## Get the credentials

PASSWORD=$(kubectl get secret mxinfo-elastic-es-elastic-user -n elastic-system -o=jsonpath='{.data.elastic}' | base64 --decode)

## Get endpoint

k port-forward -n elastic-system svc/mxinfo-elastic-es-http 9200

curl -u "elastic:$PASSWORD" -k "https://localhost:9200"

## Deploy Kibana

k apply -f kibana.yaml -n elastic-system

k get kibana -n elastic-system

kubectl get pod --selector='kibana.k8s.elastic.co/name=mxinfo-kibana'

k get service mxinfo-kibana-kb-http -n elastic-system


kubectl port-forward service/mxinfo-kibana-kb-http 5601

## Deploy APM

k apply -f apm.yaml -n elastic-system


curl -L -O https://raw.githubusercontent.com/elastic/elastic-agent/8.15/deploy/kubernetes/elastic-agent-managed-kubernetes.yaml


kubectl apply -f https://raw.githubusercontent.com/open-telemetry/opentelemetry-collector/v0.85.0/examples/k8s/otel-config.yaml

## Try this with FluentBit?

https://medium.com/@rahul.bobadi/exporting-kubernetes-logs-to-elasticsearch-using-fluent-bit-3690c1888f4a


Manual deploy to AKS
