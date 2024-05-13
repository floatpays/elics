defmodule Elics.MixProject do
  use Mix.Project

  def project do
    [
      app: :elics,
      version: "0.1.0",
      elixir: "~> 1.14",
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:nimble_parsec, "~> 1.4"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.3", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Wilhelm H Kirschbaum"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/floatpays/za_id_number"}
    ]
  end

  defp description do
    "iCalendar file parser."
  end
end
