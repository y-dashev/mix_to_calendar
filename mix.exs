defmodule MixToCalendar.MixProject do
  use Mix.Project

  def project do
    [
      app: :mix_to_calendar,
      version: "0.0.1",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      source_url: "https://github.com/y-dashev/mix_to_calendar",
      description: description(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Generating URLs for calendars with Elixir."
  end

  defp package() do
    [
      files: ~w(lib  .formatter.exs mix.exs README* license*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/y-dashev/mix_to_calendar"}
    ]
  end


  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
