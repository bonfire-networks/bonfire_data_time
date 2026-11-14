Code.eval_file("mess.exs", (if File.exists?("../../lib/mix/mess.exs"), do: "../../lib/mix/"))

defmodule Bonfire.Data.Time.MixProject do
  use Mix.Project

  def project do
    if System.get_env("AS_UMBRELLA") == "1" do
      [
        build_path: "../../_build",
        config_path: "../../config/config.exs",
        deps_path: "../../deps",
        lockfile: "../../mix.lock"
      ]
    else
      []
    end
    ++
    [
      app: :bonfire_data_time,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      description:
        "Database models for times and schedules in the bonfire ecosystem, such as when something begins and ends",
      homepage_url: "https://github.com/bonfire-networks/bonfire_data_time",
      source_url: "https://github.com/bonfire-networks/bonfire_data_time",
      package: [
        licenses: ["MPL 2.0"],
        links: %{
          "Repository" => "https://github.com/bonfire-networks/bonfire_data_time",
          "Hexdocs" => "https://hexdocs.pm/bonfire_data_time"
        }
      ],
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      deps:
        Mess.deps([
          {:needle, "~> 0.7"},
          # validates time zone names
          {:tzdata, "~> 1.1"},
          {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
        ])
    ]
  end

  def application, do: [extra_applications: [:logger]]
end
