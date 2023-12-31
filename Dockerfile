FROM hexpm/elixir:1.15.0-erlang-26.0.1-alpine-3.18.2 as builder

# install build dependencies
RUN apk add --no-cache --update git build-base

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

# compile project
COPY lib lib
RUN mix do compile

# Compile the release
COPY config/runtime.exs config/
RUN mix release

FROM alpine:3.18.2

RUN apk add --no-cache --update openssl libstdc++ ncurses

WORKDIR "/app"

ENV MIX_ENV="prod"
COPY --from=builder /app/_build/${MIX_ENV}/rel/d ./

RUN adduser -H -S -u 999 -G nogroup -g '' d
USER 999

CMD D_SERVER=1 /app/bin/d start
