# Install Istio CRDs

k apply -f istio-init.yaml

# Install Istio

k apply -f install-istio.yaml

# Add kiali secret

k apply -f kiali-secret.yaml

# Create application namespace

k apply -f demo-namespace.yaml

# Create the demo application

k apply -f demo-app.yaml -n demo-app