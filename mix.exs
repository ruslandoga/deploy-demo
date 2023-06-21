defmodule D.MixProject do
  use Mix.Project

  def project do
    [
      app: :d,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {D.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.14"},
      {:bandit, "~> 1.0-pre"}
    ]
  end

  def releases do
    [d: [include_executables_for: [:unix]]]
  end
end
