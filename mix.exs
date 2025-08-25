Code.compiler_options(on_undefined_variable: :warn)

defmodule Pepicrft.MixProject do
  use Mix.Project

  def project do
    [
      app: :pepicrft,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      # Docs
      name: "Pepicrft",
      source_url: "https://github.com/pepicrft/website",
      homepage_url: "https://pepicrft.me",
      docs: [
        main: "Pepicrft",
        extras: ["README.md"]
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Pepicrft.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:nimble_publisher,
       git: "https://github.com/dashbitco/nimble_publisher",
       ref: "0e15893fc73637887f752addeed585829eb0eec2"},
      {:phoenix, "~> 1.8.0", override: true},
      {:phoenix_ecto, "~> 4.6.0"},
      {:yaml_elixir, "~> 2.11.0"},
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 4.2.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.1.0"},
      {:floki, ">= 0.30.0", only: :test},
      {:phoenix_live_dashboard, "~> 0.8.0"},
      {:esbuild, "~> 0.10.0", runtime: Mix.env() == :dev},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.26"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},
      {:ex_doc, "~> 0.38", only: :dev, runtime: false},
      {:timex, "~> 3.7"},
      {:sweet_xml, "~> 0.7.3"},
      {:pandex, "~> 0.2.0"},
      {:image, "~> 0.62.0"},
      {:file_system, "~> 1.0"},
      {:remote_ip, "~> 1.1"},
      {:req, "~> 0.5.0"},
      {:ecto_sqlite3, "~> 0.21"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["esbuild.install --if-missing"],
      "assets.build": ["esbuild default", "phx.gen.open_graph"],
      "assets.deploy": [
        "esbuild default --minify",
        "phx.digest",
        "phx.gen.open_graph"
      ]
    ]
  end
end
