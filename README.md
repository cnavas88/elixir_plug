# Elixir plug

Reference for Plug-based applications

## Installation

Follow [these instructions](https://gist.github.com/rubencaro/6a28138a40e629b06470) to install `asdf` and needed dependencies on your system. Then from inside the project folder run `asdf install` to install fixed versions of Elixir/Erlang for the project. Then `mix deps.get` to get dependencies.

## Development

Run `./watch.sh` to run tests anytime a file is changed. See `rerun.sh` for tweakings.

# Harakiri functions

We can execute some function with harakiri:

- restart: This function does a restart the elixir program. Use: 
```touch PROJECT_ROUTE/tmp/restart```

- logger_level: This function changes the level of logger application. The 
options are: info, debug, error, warn. Use:
```echo "OPTION" PROJECT_ROUTE/tmp/loggerl_level```

# For inicialize project with docker 

docker build -t elixir_plug:0.0.1 .
docker run -d -p 80:4001 --name elixir_plug elixir_plug:0.0.1