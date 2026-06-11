# ollama-with-tailscale
AIによって作成されました。


1.https://login.tailscale.com/admin/settings/keys にアクセスし、Authキーを生成  
2.Authキーをentrypoint.shに書き込む  
3.Dockerのイメージを手元の環境でビルドし、指定のレジストリにpush  
4.サーバーにollama.jobを配置しslurmで実行
```
sbatch ollama.job
```
> [!NOTE]
> ストレージを永続化していないので、毎回モデルをダウンロードする必要があり。また、TailScale のセッションが毎回変わります。

5.手元の環境にもollamaをインストールし、環境変数で接続先を指定  
```
$env:OLLAMA_HOST="http://ollama-app:21434"
```
6.モデルをダウンロードし会話を開始する。  
```
ollama run qwen3.6:35b
```

## Coding Agentとして使う場合
1.VSCodeにRoo Codeをインストールして設定
> [!NOTE]
> RooCodeで指定するモデルは上記のコマンドで事前にダウンロードしておく必要がある


qwen3系統:概ね動作。diffツールの呼び出しが不安定  
qwen-coder:ツールの呼び出しがほとんど不可能
