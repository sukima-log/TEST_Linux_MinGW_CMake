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

# 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : MinGW install!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

sudo apt-get update

# wget install
sudo apt-get install gpg wget -y

# MinGW install
sudo apt install mingw-w64 -y
sudo apt-get install g++-mingw-w64-i686
sudo apt-get install binutils-mingw-w64-x86-64 -y
sudo apt-get install mingw-w64-common -y
sudo apt-get install mingw-w64-x86-64-dev -y
sudo apt-get install mingw-w64-tools -y
sudo apt-get install gcc-mingw-w64-base -y
sudo apt-get install gcc-mingw-w64-x86-64 -y
sudo apt-get install g++-mingw-w64-x86-64 -y
sudo apt-get install libsndfile1-dev -y

# version確認
x86_64-w64-mingw32-gcc --version


# 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : CMake install!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

sudo apt-get update

# CMake install
sudo apt install cmake -y

# version確認
cmake --version


# 処理を一時停止 -> Enterキーで進む
echo "======================================================"
echo "comment : PortAudio install!!"
echo "comment : If you want to proceed, press the Enter key!!"
echo "======================================================"
read Wait

sudo apt-get update

# PortAudio install
mkdir portaudio_build
cd portaudio_build

sudo apt-get install build-essential -y


git clone https://github.com/PortAudio/portaudio

# ビルド用ディレクトリ
cd portaudio
mkdir build
cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr/x86_64-w64-mingw32 \
    -DCMAKE_TOOLCHAIN_FILE=$CURRENT/../toolchain.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON ..

make

sudo make install

