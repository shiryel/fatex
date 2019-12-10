defmodule FatexWeb.Plug.GenerateCSRF do
  @moduledoc """
  Used to handle the csrf token on image upload on live_view
  """
  import Plug.Conn
  def init(_opts), do: nil

  def call(conn, _opts) do 
    put_session(conn, :csrf_token, Phoenix.Controller.get_csrf_token())
  end
end
