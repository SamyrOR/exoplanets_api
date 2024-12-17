defmodule ExoplanetsApiWeb.ExoplanetsController do
  use ExoplanetsApiWeb, :controller
  alias ExoplanetsApi.Exoplanets

  def get(conn, _params) do
    with {:ok, body, _conn} <- Plug.Conn.read_body(conn),
         {:ok, %{"args" => args}} <-
           Jason.decode(body) do
      case Exoplanets.filter_with_args(args) do
        {:ok, planets} -> json(conn, %{data: planets})
      end
    else
      _ ->
        random(conn, {})
    end
  end

  def random(conn, _params) do
    with {:ok, planets} <- Exoplanets.random_planets() do
      json(conn, %{data: planets})
    else
      _ -> put_status(conn, 422) |> json(%{error: "try again later"})
    end
  end
end
