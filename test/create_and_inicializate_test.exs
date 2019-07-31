defmodule ElixirPlug.EtsHolder.Inicialize.BadDatesTesting do
  @moduledoc """
  Bad testing module
  """

  def inicialize, do: [:error, :error]
end

defmodule ElixirPlug.EtsHolder.Inicialize.PartialDatesTesting do
  @moduledoc """
  Bad testing module
  """

  def inicialize, do: [:error, {:ok, "ok"}]
end

defmodule ElixirPlug.EtsHolder.Inicialize.GoodDatesTesting do
  @moduledoc """
  Bad testing module
  """

  def inicialize, do: [{:ok, "ok"}]
end

defmodule CreateAndInicializateTest do
  @moduledoc false
  use ExUnit.Case

  alias ElixirPlug.EtsHolder.CreateAndInicialize

  test "Create ets table with error" do
    create_ets_fn = fn _, _ ->
      {:error, :ets_not_created}
    end

    opts = [
      name: 23,
      typed: :set,
      module: nil,
      create_ets_fn: create_ets_fn
    ]

    result = CreateAndInicialize.run(opts)
    assert result == {:error, :ets_not_created}
  end

  test "Not exists atom module" do
    create_ets_fn = fn _, _ ->
      {:ok, :example_test}
    end

    opts = [
      name: :example_test,
      typed: :set,
      module: :not_exists,
      create_ets_fn: create_ets_fn
    ]

    result = CreateAndInicialize.run(opts)
    assert result == {:error, :module_doesnt_exist}
  end

  test "Error in insert data, create table ok" do
    create_ets_fn = fn _, _ ->
      {:ok, :example_test}
    end

    insert_ets_fn = fn _, data ->
      case data do
        :error      -> {:error, :not_insert}
        {:ok, "ok"} -> true
      end
    end

    opts = [
      name: :example_test,
      typed: :set,
      module: :BadDatesTesting,
      create_ets_fn: create_ets_fn,
      insert_ets_fn: insert_ets_fn
    ]

    result = CreateAndInicialize.run(opts)
    assert result == :ok
  end

  test "Warning in insert data, only insert partial data, create table ok" do
    create_ets_fn = fn _, _ ->
      {:ok, :example_test}
    end

    insert_ets_fn = fn _, data ->
      case data do
        :error      -> {:error, :not_insert}
        {:ok, "ok"} -> true
      end
    end

    opts = [
      name: :example_test,
      typed: :set,
      module: :PartialDatesTesting,
      create_ets_fn: create_ets_fn,
      insert_ets_fn: insert_ets_fn
    ]

    result = CreateAndInicialize.run(opts)
    assert result == :ok
  end

  test "create table ok and insert data ok" do
    create_ets_fn = fn _, _ ->
      {:ok, :example_test}
    end

    insert_ets_fn = fn _, data ->
      case data do
        :error      -> {:error, :not_insert}
        {:ok, "ok"} -> true
      end
    end

    opts = [
      name: :example_test,
      typed: :set,
      module: :GoodDatesTesting,
      create_ets_fn: create_ets_fn,
      insert_ets_fn: insert_ets_fn
    ]

    result = CreateAndInicialize.run(opts)
    assert result == :ok
  end

end
