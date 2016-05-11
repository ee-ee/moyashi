#![Logo](https://i.imgur.com/qlIRj4d.png)ｍｏｙａｓｈｉ

Imageboards done right.

## Requirements

```
sudo pacman -S elixir npm git make imagemagick sassc
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
