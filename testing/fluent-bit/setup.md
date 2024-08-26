
# Install Fluent-Bit on MacOS

````
brew install fluent-bit
````


## Running the log simulator

````
docker pull mp3monster/flb-logsim
````
Tag image for local use

````
docker image tag mp3monster/flb-logsim logsimcontainer-logger:latest

````

### Testing

````
fluent-bit -q -i dummy -p dummy="{\"hello\":\"my world\"}" -o stdout -m "*"
````