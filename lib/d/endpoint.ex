defmodule D.Endpoint do
  @moduledoc false
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    message = D.config!(:message)
    send_resp(conn, 200, message)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
