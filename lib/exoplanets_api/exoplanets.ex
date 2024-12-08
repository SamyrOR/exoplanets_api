defmodule ExoplanetsApi.Exoplanets do
  alias NimbleCSV.RFC4180, as: CSV

  def init do
    File.stream!("priv/static/PS_2024.12.05_17.14.02.csv")
    |> CSV.parse_stream()
    |> Enum.to_list()
    |> IO.inspect()
  end

  def filter_with_args(stream, [head | tail]) do
    stream =
      stream
      |> Stream.filter(fn item ->
        Enum.member?(item, head)
      end)

    filter_with_args(stream, tail)
  end

  def filter_with_args(stream, []) do
    stream
  end
end
