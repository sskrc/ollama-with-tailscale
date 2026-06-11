#!/bin/bash

# === 1. 環境変数を設定して Tailscale を安全に起動 ===
# TS_USERSPACE=true を指定することで、iptables などの特権操作を自動でスキップします
export TS_USERSPACE=true

tailscaled \
  --state=/var/lib/tailscale/tailscaled.state \
  --socket=/var/run/tailscale/tailscaled.sock \
  --tun=userspace-networking \
  --socks5-server=localhost:1055 \
  --outbound-http-proxy-listen=localhost:1056 &

# Tailscaled の立ち上がりを少し待つ
sleep 3

# === 2. 認証キーで自動ログイン ===
# ※ご自身のキー（tskey-auth-...）に書き換えてください。
AUTH_KEY="tskey-auth-"

tailscale up \
  --auth-key="$AUTH_KEY" \
  --accept-routes=false \
  --hostname=ollama-app

# === 3. Ollama をフォアグラウンドで起動 ===
export OLLAMA_HOST=0.0.0.0:21434
exec ollama serve
