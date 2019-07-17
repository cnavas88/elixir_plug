defmodule ElixirPlug.Web.MetricsExporter do
  @moduledoc """
  Exposes the /metrics path and responds in Prometheus metrics format.
  See used Prometheus.PlugExporter module for details.
  """
  use Prometheus.PlugExporter
end
