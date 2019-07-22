defmodule Bidtor.EtsHolder.CreateAndInicialize do
  @moduledoc """
  This module will create and inicialize the ets tables with a module of
  inicialize dates.
  """
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: :create_and_inicialize_worker)
  end

  def init(_) do
    IO.puts "CREATE AND INICIALIZE THE ETS TABLES"
    {:ok, nil}
  end
end
