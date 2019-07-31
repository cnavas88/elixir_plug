defmodule ElixirPlug.EtsHolder.Worker do
  @moduledoc """
  This module will create and inicialize the ets tables with a module of
  inicialize dates.
  """
  use GenServer

  require Logger

  alias ElixirPlug.EtsHolder.CreateAndInicialize

  @spec start_link(map) :: Supervisor.on_start

  def start_link(opts) do
    Logger.info("> Init GenServer --> #{inspect opts.name}")
    GenServer.start_link(
      __MODULE__,
      opts,
      name: opts.name
    )
  end

  @impl GenServer

  def init(opts) do
    {:ok, opts, {:continue, :ets_generate}}
  end

  @impl GenServer

  def handle_continue(:ets_generate, opts) do
    case CreateAndInicialize.run(to_keyword_list(opts)) do
      :ok ->
        Logger.info("> End GenServer --> #{inspect opts.name}")
        {:noreply, opts}

      {:error, reason} ->
        {:stop, reason, opts}
    end
  end

  @impl GenServer

  def terminate(reason, _opts) do
    Logger.error("> Terminate GenServer with error reason --> #{inspect reason}")
    :normal
  end

  # Auxiliary functions

  defp to_keyword_list(dict) do
    Enum.map(dict, fn({key, value}) -> {key, value} end)
  end
end
