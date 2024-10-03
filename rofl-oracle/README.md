
## How to Install

```
# change timezone to Singapore
sudo timedatectl set-timezone Asia/Singapore

sudo apt update
sudo apt upgrade -y

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source ~/.bashrc

rustup target add x86_64-unknown-linux-musl
sudo apt install -y musl-tools gcc-multilib clang build-essential

sudo apt install -y gcc pkg-config libssl-dev protobuf-compiler

cargo install fortanix-sgx-tools  
cargo install sgxs-tools

sudo apt install cpuid
cpuid -1 | grep "SGX"

# DCAP Attestation

curl -fsSL https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | sudo gpg --dearmor -o /usr/share/keyrings/intel-sgx-deb.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/intel-sgx-deb.gpg] https://download.01.org/intel-sgx/sgx_repo/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/intel-sgx.list > /dev/null
sudo apt update
sudo apt install sgx-aesm-service libsgx-aesm-ecdsa-plugin libsgx-aesm-quote-ex-plugin libsgx-dcap-default-qpl
sudo systemctl status aesmd.service

## Configure Quote Provider for Azure

# /etc/sgx_default_qcnl.conf
sudo cat > /etc/sgx_default_qcnl.conf <<EOF
{ 
    "pccs_url": "https://global.acccache.azure.net/sgx/certification/v3/", 
    "use_secure_cert": true, 
    "collateral_service": "https://global.acccache.azure.net/sgx/certification/v3/",  
    "pccs_api_version": "3.1", 
    "retry_times": 6, 
    "retry_delay": 5, 
    "local_pck_url": "http://169.254.169.254/metadata/THIM/sgx/certification/v3/",
    "pck_cache_expire_hours": 24, 
    "verify_collateral_cache_expire_hours": 24, 
    "custom_request_options": { 
        "get_cert": { 
            "headers": { 
                "metadata": "true" 
            }, 
            "params": { 
                "api-version": "2021-07-22-preview" 
            } 
        } 
    } 
}
EOF

sudo systemctl restart aesmd 
systemctl status aesmd

# Install Oasis Attestation Tool
mkdir downloads
cd downloads
wget https://github.com/oasisprotocol/tools/releases/download/attestation-tool-0.3.4/attestation-tool
chmod 755 attestation-tool
./attestation-tool

# Project Repo
cd ~
mkdir projects
cd projects
git clone https://github.com/darrylyeo/ethglobal-singapore-2024.git


# Install Docker

## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Install latest Docker Packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

## Update permission on docker socket, required by oasis docker image
sudo chmod 666 /var/run/docker.sock

```