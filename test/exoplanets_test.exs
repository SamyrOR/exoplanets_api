defmodule ExoplanetsApi.Test.ExoplanetsTest do
  use ExUnit.Case

  alias ExoplanetsApi.Exoplanets

  test "filter_with_args/1 returns a list of maps" do
    args = ["pl_name", "hostname"]
    {:ok, result} = Exoplanets.filter_with_args(args)
    {:ok, result} = Jason.decode(result)
    assert is_list(result)
    assert Enum.all?(result, &is_map/1)
  end

  test "filter_with_args/1 filters correctly" do
    args = ["Kepler-62 f"]
    {:ok, result} = Exoplanets.filter_with_args(args)
    {:ok, result} = Jason.decode(result)
    assert length(result) == 1
    assert hd(result)["pl_name"] == "Kepler-62 f"
  end
end
