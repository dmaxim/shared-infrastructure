# Install Traefik

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm search repo traefik --versions
helm install traefik traefik/traefik --namespace traefik --create-namespace -f ./values.yaml --version 38.0.1

k describe GatewayClass traefik

k describe Gateway traefik -n traefik