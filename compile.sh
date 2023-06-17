#!/bin/sh

# 実行用ディレクトリ作成
mkdir build
cd build

# buildディレクトリ内に入り、cmakeで自動ビルド
cmake -DCMAKE_TOOLCHAIN_FILE=./toolchain.cmake -DCMAKE_BUILD_TYPE=Release ..

# makefileができるので、実行ファイルを作成する
make

# 実行バイナリに必要な動的ライブラリをCmakeLink.txt記述にしたがってインストール
make install


# 実行ファイルを/build/install/bin以下に移動
# cp ./build/myexe.exe ./build/install/bin/