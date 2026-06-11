FROM ollama/ollama:latest

# 必要なパッケージのインストールとTailscaleのセットアップ
RUN apt-get update && apt-get install -y curl iptables && \
    curl -fsSL https://tailscale.com/install.sh | sh && \
    rm -rf /var/lib/apt/lists/*

# 状態保存用のディレクトリを作成
RUN mkdir -p /var/lib/tailscale /var/run/tailscale

# 起動スクリプトの配置
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# エントリーポイントの設定
ENTRYPOINT ["/entrypoint.sh"]
