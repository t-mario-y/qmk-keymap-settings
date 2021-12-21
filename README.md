# QMK settings

QMKのキーマップを管理する。手順は下記の通り:

- YAMLで書いたkeymapをGit管理しておく。
- [yq cli](https://github.com/mikefarah/yq)により、YAMLをJSONに変換する。

```shell script
cat ./my_ergodash_keymap.yaml | yq e -oj > ./my_ergodash_keymap.json
```

- [QMK Configurator](https://config.qmk.fm/)でJSONからhexに変換する。
- [QMK toolbox](https://github.com/qmk/qmk_toolbox)でファームウェアを書き込む。
  - 左右のキーボードを片方ずつ焼く必要があることに注意すること。

## Why

QMKによるキーマップカスタマイズは奥深く、自作キーボードを選ぶ積極的な理由になっている。
しかしながらその設定方法には一長一短がある。

### VIA、Remap

- ✨ブラウザからHIDデバイスへのアクセスを許可すれば、ローカルに何もインストールせずとも動作する。
- ☠️後発ツールのため古いモデルのキーボードが対応していない。

### QMK cli

- ✨世界中のあらゆる自作キーボードが集まっているため、自分で設計したもの以外はほぼ全て揃っている。
- ✨C++にてファームウェアで動作するコードを書けるため、設定可能な幅が非常に広い。
  - 例えば、tap dance(2連打で別のキーコード割当)はQMK configuratorで設定できないことが知られている。その他の制約は[サリチル酸さんのブログ](https://salicylic-acid3.hatenablog.com/entry/qmk-configurator)を参照のこと
- ☠️CLIのセットアップに際してPCのパッケージ管理が難しい。
  - ただ設定を管理するだけなのに、あらゆるキーボードの設定が詰まったqmkリポジトリを自分でフォークした上で、依存関係が大量に含まれるQMK CLIをbrew installする必要がある。
  - dockerコンテナによる起動も試されているが、そもそも入力デバイスに対して書き込みを行うという性質上、コンテナ上で動作するアプリケーションでは難しい。参考: [Why can't I flash on Windows/macOS](https://beta.docs.qmk.fm/using-qmk/guides/development-environments/getting_started_docker#why-cant-i-flash-on-windows-macos)(Linuxだとスっと動くようだ。)

### QMK toolbox + QMK configurator

- QMK toolboxはhexファイルをPro Microに書き込む。
  - 原則、qmk_firmwareリポジトリで管理されるキーボードは対応しているため対応機種が広い。
- いっぽうでhexファイルの生成は、やや使いづらいQMK configurator に頼る必要がある。
- ブラウザに結果として出力されるレイアウトはきれいだが、設定ファイルをJSONで記述する必要がある。
  - どのレイヤー/どのキーに何を当てるかをJSONで書いて管理するのは辛いことが多い。
    - JSONにはコメントが一切書けない。
    - prettierをかけると配列項目が問答無用で改行され、コメントや項目ごとの改行無視を仕込むことができない。

以上のことから、キーバインドをYAMLで記述し、QMK configuratorとのやりとりはJSONに変換して行うことが最もコンパクトな管理につながると考えた。

qmk_firmware リポジトリは現状は残しておくが、二重管理になるためいずれ消去したい。

Ergodashのkeymapは <https://github.com/t-mario-y/qmk_firmware/blob/master/keyboards/ergodash/rev1/keymaps/t-mario-y/keymap.c>  
Manta60のkeymapは <https://github.com/t-mario-y/qmk_firmware/blob/master/keyboards/manta60/keymaps/t-mario-y/keymap.c>  
