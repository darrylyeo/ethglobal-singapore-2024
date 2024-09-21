### Install protobuf

```bash
PROTOC_ZIP=protoc-3.15.8-linux-x86_64.zip
curl -OL https://github.com/google/protobuf/releases/download/v3.15.8/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
sudo unzip -o $PROTOC_ZIP -d /usr/local include/*
rm -f $PROTOC_ZIP
```

```bash
sudo apt update
apt install -y protobuf-compiler
```

### Compile ROFL in the unsafe mode:

```bash
# /workspace/ethglobal-singapore-2024/rofl-oracle$
../oasis_cli_0.10.1_linux_amd64/oasis rofl build sgx --mode unsafe
```

### Spin up the Sapphire Localnet docker container and mount your rofl-oracle folder to /rofls inside the docker image:

```bash
docker run -it -p8545:8545 -p8546:8546 -v rofl-oracle:/rofls ghcr.io/oasisprotocol/sapphire-localnet
```
