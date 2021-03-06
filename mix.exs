defmodule ExDiet.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_diet,
      version: "0.0.2",
      elixir: "~> 1.9",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],
      deps_path: System.get_env("DEPS_PATH") || Mix.Project.deps_path(),
      build_path: build_path()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {ExDiet.Application, []},
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
      {:phoenix, "~> 1.4.9"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 4.0"},
      {:postgrex, ">= 0.0.0"},
      {:cors_plug, "~> 2.0"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:bcrypt_elixir, "~> 2.0"},
      {:guardian, "~> 2.0"},
      {:guardian_db, "~> 2.0"},
      {:absinthe, "~> 1.4.9"},
      {:absinthe_plug, "~> 1.4.2"},
      {:absinthe_relay, "~> 1.4.2"},
      {:absinthe_phoenix, ">= 0.0.0"},
      {:dataloader, "~> 1.0.0"},
      {:gettext, "~> 0.11"},
      {:edeliver, "~> 1.7"},
      {:distillery, "~> 2.0", runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_machina, "~> 2.2", only: :test},
      {:excoveralls, "~> 0.8", only: :test},
      {:cowboy, "~> 2.0"},
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:logger_file_backend, "~> 0.0.11"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end

  defp build_path do
    System.get_env("BUILD_PATH") || default_build_path()
  end

  defp default_build_path do
    Mix.Project.build_path()
    |> String.replace("/#{Mix.env()}", "")
  end
end
