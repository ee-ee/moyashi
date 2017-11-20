FROM elixir:alpine

RUN apk update && \
    apk --no-cache --update add \
        curl inotify-tools && \
    update-ca-certificates --fresh && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

WORKDIR /code

ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

ADD . .

EXPOSE 4000

CMD ["mix", "phx.server"]