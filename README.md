# 🌱 ｍｏｙａｓｈｉ

Imageboards done right.

## Requirements

```
sudo pacman -S elixir npm git
```

## Installation

```
git clone https://github.com/hails/moyashi.git
cd moyashi
mix deps.get
npm install
node node_modules/brunch/bin/brunch build
mix ecto.create
mix ecto.migrate
mix phoenix.server
```
