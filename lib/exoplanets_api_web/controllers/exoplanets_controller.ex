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
      _ -> put_status(conn, 422) |> json(%{error: "Invalid arguments"})
    end
  end
end
