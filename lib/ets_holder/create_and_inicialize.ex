defmodule Bidtor.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module will create and inicialize the ets tables with a module of
  inicialize dates.
  """
  use GenServer

  def start_link({name, module}) do
    GenServer.start_link(
      __MODULE__,
      [name: name, module: module],
      name: name
    )
  end

  def init(opts) do
    create_ets_table(opts)
    {:ok, nil}
  end

  defp create_ets_table(opts) do
    :ets.new(opts[:name], [:public, :named_table, :set])
  end
end
