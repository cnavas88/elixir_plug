defmodule Bidtor.EtsHolder.Supervisor do
  @moduledoc """
  This supervisor contains the worker that it will create and inicializate
  the ets tables.
  """
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: :ets_holder_supervisor)
  end

  def init(opts) do
    ets_tables = Application.get_env(:elixir_plug, :ets_tables)

    IO.puts "ETS TABLES :: #{inspect ets_tables}"

    childrens = [
      worker(Bidtor.EtsHolder.CreateAndInicialize, opts, restart: :permanent)
    ]

    supervise(childrens, strategy: :one_for_one)
  end
end
