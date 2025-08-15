## Pact Broker Helm

helm repo add 

helm install pact-broker pact-broker/pact-broker --namespace pact-broker-poc --values ./values.yaml

helm upgrade pact-broker pact-broker/pact-broker --namespace pact-broker-poc --values ./values.yaml

helm uninstall pact-broker --namespace pact-broker-poc

broker.config.basicAuth.enabled

https://docs.pact.io/pact_broker/kubernetes/readme



helm template pact-broker pact-broker/pact-broker --namespace pact-broker-poc --values=./values.yaml > pact-install.yaml


## Next steps
- Branch of shared infrastructure
- create pact-broker-folder - terraform and deployment
- Create azure infrastructure
- Deploy pact broker - using ArgoCD
- test
- Add ingress