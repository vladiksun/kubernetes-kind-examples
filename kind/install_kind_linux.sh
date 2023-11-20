# https://kind.sigs.k8s.io/docs/user/quick-start

KIND_LOCATION=/home/vbondarchuk/.local/bin/

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
mkdir --parents $KIND_LOCATION
mv ./kind $KIND_LOCATION
kind