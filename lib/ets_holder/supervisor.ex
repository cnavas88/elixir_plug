defmodule ElixirPlug.EtsHolder.Supervisor do
  @moduledoc """
  This supervisor contains the worker that it will create and inicializate
  the ets tables.
  """
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: :ets_holder_supervisor)
  end

  def init(_opts) do
    ets_conf = Application.get_env(:elixir_plug, :ets_tables)

    childrens = generate_childs(ets_conf)

    supervise(childrens, strategy: :one_for_one)
  end

  defp generate_childs(ets_conf) do
    Enum.map(ets_conf, fn config ->
      worker(
        ElixirPlug.EtsHolder.Worker,
        [config],
        [restart: :permanent, id: config.name]
      )
    end)
  end
end
