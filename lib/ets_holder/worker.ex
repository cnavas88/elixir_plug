defmodule ElixirPlug.EtsHolder.Worker do
  @moduledoc """
  This module will create and inicialize the ets tables with a module of
  inicialize dates.
  """
  use GenServer

  alias ElixirPlug.EtsHolder.CreateAndInicialize

  @spec start_link(map) :: Supervisor.on_start

  def start_link(opts) do
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
    case CreateAndInicialize.run(opts) do
      :ok ->
        {:noreply, opts}

      {:error, reason} ->
        {:stop, reason, opts}
    end
  end

end
