# - TEST_Linux_MinGW_CMake -


- 上記 [ main.cpp ] 内のコードは、OSで設定している基本入力（マイク等）で入力した音声を、基本出力（ヘッドホンやスピーカー等）に出力するだけのコード
- WSL2等のLinux環境を用いて、Windows用にソースコードをコンパイルするテストコード
<br>


# ＃環境構築

「environment」ディレクトリ以下に環境構築のためのシェルスクリプト等あり<br>
　
- 基本Ubuntu環境で使うことを想定（apt）
- 他環境の場合は、Dockerを用いてdockerfileにて環境構築可能
- あるいは、aptコマンド等読み替え&書き換えして、手動でシェルスクリプト実行でもOK


## ・シェルスクリプトで環境構築する場合

- `environment.sh`コマンドを実行
- あえて各ライブラリ等インストールごとに一時停止するようにしているので、一時停止のたびにEnterを押していると自動的に環境構築される。

## ・Dockerを使って環境構築する場合

- Ubuntu環境（WSL2）：
    - `docker_ubuntu.sh`コマンドでDockerの環境構築から、イメージの作成まで行われる。
    - 作成したコンテナ内で`./TEST_Linux_MinGW_CMake/environment/environment.sh`を実行 -> 環境構築

- その他環境：
    - [docker_ubuntu.sh]内のコマンドを適宜読み替えて、Docker等のインストール
    - [environment/dockerfile]を用いてDockerイメージの作成
    - 作成したコンテナ内で`./TEST_Linux_MinGW_CMake/environment/environment.sh`を実行 -> 環境構築

## ・Dockerコマンド簡易まとめ

- 取得済みイメージ表示<br>
    - `docker images`<br>
- コンテナ確認（STATUS等確認）<br>
    - `docker ps -a`<br>
- コンテナの生成&起動<br>
    - `docker run -d -it --name <コンテナ名> <イメージ名>:<タグ>`<br>
    - 例：`docker run -d -it --name lmc tlmc:1.0`<br>
- コンテナの起動<br>
    - `docker start <コンテナ名>`<br>
- コンテナの停止<br>
    - `docker stop <コンテナ名>`<br>
- コンテナ内に入る<br>
    - `docker exec -it <コンテナ名> <実行するコマンド>`<br>
    - 例：`docker exec -it containerA /bin/bash`<br>
- コンテナの削除<br>
    - `docker rm <CONTAINER ID>`<br>
- イメージの削除<br>
    - `docker rmi <IMAGE ID>`<br>


<br>


# ＃実行方法


以下、スクリプト[compile.sh]を実行することで手順4、`make install`まで自動実行

<hr>

1. 実行用のディレクトリを作る<br>
- `mkdir build`<br>
- `cd build`

2. buildディレクトリ内に入り、cmakeで自動ビルドする<br>
- `cmake -DCMAKE_TOOLCHAIN_FILE=./toolchain.cmake -DCMAKE_BUILD_TYPE=Release ..`<br>


3. makefileができるので、実行ファイルを作成する<br>
- `make`<br>



4. 実行バイナリに必要な動的ライブラリをCMakeLink.txtの記述にしたがって自動的にとってくる<br>
- `make install`<br>

5. /install/以下のbinディレクトリに[.dll]ファイルなどの[.exe]ファイルの実行に必要な動的ライブラリが入る。<br>


6. 実行ファイルを/install/bin以下に移動させて、Windows側のフォルダにbinごと移動させる<br>

7. Windows側で/binフォルダに入り、コマンドプロンプトを立ち上げて実行ファイルを実行する。<br/>
　※本来は、対象ライブラリの動的ライブラリファイル「.dll」と実行ファイル「.exe」さえあれば動作可能

<br>


# ＃環境の初期化

スクリプト[clean.sh]を実行で[compile.sh,environment.sh]で作成した/build等削除してディレクトリの初期化可能
