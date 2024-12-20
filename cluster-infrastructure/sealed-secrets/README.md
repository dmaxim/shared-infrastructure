# Installing Kubeseal

````
brew install kubeseal
````


## Using kubeseal

Get the public key from the controller 

````

kubeseal --fetch-cert > publickey.pem

````

Encrypt

````
kubeseal --format=yaml --cert=publickey.pem < secret.yaml > sealed-secret.yaml

rm publickey.pem
rm secret.yaml

````