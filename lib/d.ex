defmodule D do
  @moduledoc """
  Documentation for `D`.
  """

  @app :d

  def config(key), do: Application.get_env(@app, key)
  def config!(key), do: Application.fetch_env!(@app, key)
end
