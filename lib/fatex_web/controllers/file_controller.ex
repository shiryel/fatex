defmodule FatexWeb.FileController do
  use FatexWeb, :controller
  alias Render.Core.FileHandler
  require Logger

  def get(conn, %{"model_id" => model_id}) do
    FileHandler.wait_file_creation(model_id)

    conn
    |> put_resp_content_type("application/pdf")
    |> Plug.Conn.send_file(200, FileHandler.get_path(model_id))
  end
end
