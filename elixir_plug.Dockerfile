FROM elixir:1.8.2-otp-22

COPY . .

RUN mix local.hex --force

RUN mix local.rebar --force

RUN mix deps.get

RUN mix compile