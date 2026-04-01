# Install Traefik

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm search repo traefik --versions
helm install traefik traefik/traefik --namespace traefik --create-namespace -f ./values.yaml --version 38.0.1

k describe GatewayClass traefik

k describe Gateway traefik -n traefik

helm plugin install https://github.com/databus23/helm-diff

helm diff upgrade traefik traefik/traefik --namespace traefik -f ./values.yaml --version 38.0.1

helm upgrade traefik traefik/traefik --namespace traefik -f ./values.yaml --version 38.0.1

k create secret tls traefik-tls-cert --cert=./STAR_danmaxim_net.pem --key=./STAR_danmaxim_net.key -n traefik