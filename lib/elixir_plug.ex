defmodule ElixirPlug do
  @moduledoc """
  ElixirPlug is a scaffolding project for elixir apps without phoenix.
  """
  use Application

  require Logger

  alias ElixirPlug.Web.Router
  alias Plug.Cowboy

  def start(_type, _args) do
    tmp_path = Application.get_env(:elixir_plug, :tmp_path)

    Harakiri.add(%{
      paths: ["#{tmp_path}/restart"],
      action: &restart/1
    })

    Harakiri.add(%{
      paths: ["#{tmp_path}/logger_level"],
      action: &set_logger_level/1
    })

    children =
      supervisor_ets_holder() ++
        [
          Cowboy.child_spec(
            scheme: :http,
            plug: Router,
            options: [port: Application.get_env(:elixir_plug, :port)]
          )
        ]

    opts = [strategy: :one_for_one, name: ElixirPlug.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp supervisor_ets_holder do
    case Application.get_env(:elixir_plug, :ets_tables) do
      nil -> []
      [] -> []
      _ -> [ElixirPlug.EtsHolder.Supervisor]
    end
  end

  defp set_logger_level(data) do
    path = data[:file][:path]
    content = path |> File.read!() |> String.replace("\n", "")

    if content in ["info", "debug", "warn", "error"] do
      content = content |> :erlang.binary_to_existing_atom(:utf8)
      Logger.configure(level: content)
    end
  end

  defp restart(_) do
    Logger.error("#restart# - go, go, go...")
    :init.restart()
  end
end
