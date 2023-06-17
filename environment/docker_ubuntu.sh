#bin/sh

CURRENT=$(cd $(dirname $0);pwd)
echo $CURRENT

# 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : change directory!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

# environmentに移動
cd $CURRENT

pwd

wsl.exe --set-default-version 2

sudo apt update

sudo apt install ca-certificates curl gnupg lsb-release -y

sudo mkdir -p /etc/apt/keyrings -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io -y

sudo service docker stop
sudo service docker start


# 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : Docker build & make image!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

cp ./dockerfile ../../dockerfile
cd ../../
docker build -t test_mingw_cmake:1.0 -f dockerfile .
rm ./dockerfile
cd $CURRENT