KUBECTL_LOCATION=~/.local/bin/

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mkdir --parents $KUBECTL_LOCATION
mv ./kubectl $KUBECTL_LOCATION
source ~/.profile
kubectl version