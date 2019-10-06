defmodule FatexWeb.PageController do
  use FatexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
