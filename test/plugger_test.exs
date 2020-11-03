defmodule ElixirPlugTest do
  @moduledoc false
  use ExUnit.Case
  use Plug.Test

  alias ElixirPlug.Web.Router
  alias ElixirPlug.Web.Schemas.HelloWorld, as: HelloWorldSchema

  @opts Router.init([])

  test "Returns error in hello world without parameters" do
    # Create a test connection
    conn = conn(:get, "/api/hello_world")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    decode_body = Jason.decode!(conn.resp_body)
    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 400
    assert decode_body["error"] == "name is required"
  end

  test "Returns hello world with name" do
    # Create a test connection
    conn = conn(:get, "/api/hello_world?name=Carlos")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Hello world Carlos"
  end

  test "Get Hello world Schema" do
    result = HelloWorldSchema.get_schema()
    assert is_map(result)
  end

  test "returns error 404 in api plug" do
    # Create a test connection
    conn = conn(:get, "/api/test")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
  end

  # test "returns some metrics" do
  #   # Create a test connection
  #   conn = conn(:get, "/metrics")

  #   # Invoke the plug
  #   conn = Router.call(conn, @opts)

  #   # Assert the response and status
  #   assert conn.state == :sent
  #   assert conn.status == 200

  #   # Assert contains at least 'http_requests_total' metric
  #   assert String.contains?(conn.resp_body, "http_requests_total")
  # end

  test "responds 404 to not found" do
    # Create a test connection
    conn = conn(:get, "/any")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 404
  end

  test "responds pong" do
    # Create a test connection
    conn = conn(:get, "/ping")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "Pong"
  end

  test "responds with version commit" do
    # Create a test connection
    conn = conn(:get, "/version")

    # Invoke the plug
    conn = Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "start code does not crash" do
    {:error, {:already_started, _pid}} = ElixirPlug.start(:normal, [])
  end
end
