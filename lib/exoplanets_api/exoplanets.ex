defmodule ExoplanetsApi.Exoplanets do
  alias NimbleCSV.RFC4180, as: CSV

  def init do
    File.stream!("priv/static/PS_2024.12.05_17.14.02.csv")
    |> CSV.parse_stream()
    |> Stream.filter(fn
      [_, "11 Com b" | _] -> true
      [_] -> false
      [_ | _] -> false
    end)
    |> Enum.to_list()
    |> IO.inspect()
  end
end
