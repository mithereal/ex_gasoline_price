defmodule Gasrate.MixProject do
  use Mix.Project

  @source_url "https://github.com/mithereal/ex_gasrate.git"
  @version "0.2.1"
  @app :gas_rate

  def project do
    [
      app: @app,
      version: @version,
      build_path: "./_build",
      config_path: "./config/config.exs",
      deps_path: "./deps",
      lockfile: "./mix.lock",
      elixir: "~> 1.10",
      name: "gasrate",
      source_url: @source_url,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      aliases: aliases(),
      description: description(),
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      releases: [{@app, release()}],
      preferred_cli_env: [release: :prod]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Gasrate.Cli, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:floki, "~> 0.31.0"},
      {:tesla, "~> 1.4"},
      {:hackney, "~> 1.17"},
      {:ex_doc, "~> 0.14", only: :dev},
      {:inch_ex, ">= 0.0.0", only: :docs},
      {:bakeware, runtime: false}
    ]
  end

  defp description() do
    "Fetch Gas Rates from gasprices.aaa.com."
  end

  defp package() do
    [
      name: "gasrate",
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Jason Clark"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/mithereal/ex_gasrate"}
    ]
  end

  defp aliases do
    [
      test: ["test"]
    ]
  end

  defp docs() do
    [
      main: "readme",
      name: "Gasrate",
      source_ref: "v#{@version}",
      canonical: "http://hexdocs.pm/gasrate",
      source_url: @source_url,
      extras: ["README.md"]
    ]
  end

  defp release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      quiet: true,
      steps: [:assemble, &Bakeware.assemble/1],
      strip_beams: Mix.env() == :prod
    ]
  end
end
