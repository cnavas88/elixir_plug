defmodule ElixirPlug.Metrics.HackneyTest do
  @moduledoc """
  Hackney metrics.
  In this test I use unitary test.
  """
  use ExUnit.Case, async: true

  alias ElixirPlug.Metrics.Hackney

  describe "Testing Counter and gauge metrics." do
    test "nb_requests counter/1" do
      result = Hackney.increment_counter([:hackney, "host", :nb_requests])
      assert result == :ok
    end

    test "total_requests counter/1" do
      result = Hackney.increment_counter([:hackney, :total_requests])
      assert result == :ok
    end

    test "finished_requests counter/1" do
      result = Hackney.increment_counter([:hackney, :finished_requests])
      assert result == :ok
    end

    test "new_connection counter/1" do
      result = Hackney.increment_counter([:hackney_pool, "host", :new_connection])
      assert result == :ok
    end

    test "reuse_connection counter/1" do
      result = Hackney.increment_counter([:hackney_pool, "host", :reuse_connection])
      assert result == :ok
    end

    test "no_socket counter/1" do
      result = Hackney.increment_counter([:hackney_pool, "host", :no_socket])
      assert result == :ok
    end

    test "connect_error counter/1" do
      result = Hackney.increment_counter([:hackney, "host", :connect_error])
      assert result == :ok
    end

    test "nb_requests hackney counter/1" do
      result = Hackney.increment_counter([:hackney, :nb_requests])
      assert result == :ok
    end

    test "nb_requests decrement counter/1" do
      result = Hackney.decrement_counter([:hackney, "host", :nb_requests])
      assert result == :ok
    end

    test "nb_requests decrement withoout host counter/1" do
      result = Hackney.decrement_counter([:hackney, :nb_requests])
      assert result == :ok
    end
  end

  describe "Histogram hackney test" do
    test "request_time histogram" do
      result = Hackney.update_histogram([:hackney, "host", :request_time], 40)
      assert result == :ok
    end

    test "in_use_count histogram" do
      result = Hackney.update_histogram([:hackney_pool, "host", :in_use_count], 50)
      assert result == :ok
    end

    test "free_count histogram" do
      result = Hackney.update_histogram([:hackney_pool, "host", :free_count], 60)
      assert result == :ok
    end
  end
end
