defmodule ElixirPlug.Web.MetricsInstrumenter do
  @moduledoc """
  Adds HTTP related metrics for every request.
  See used Prometheus.PlugPipelineInstrumenter module for details.
  """
  use Prometheus.PlugPipelineInstrumenter
end
