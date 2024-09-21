
### Compile ROFL in the unsafe mode:

```bash
# /workspace/ethglobal-singapore-2024/rofl-oracle$ 
../oasis_cli_0.10.1_linux_amd64/oasis rofl build sgx --mode unsafe
```

### Spin up the Sapphire Localnet docker container and mount your rofl-oracle folder to /rofls inside the docker image:

```bash
docker run -it -p8545:8545 -p8546:8546 -v rofl-oracle:/rofls ghcr.io/oasisprotocol/sapphire-localnet
```