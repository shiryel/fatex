defmodule FatexWeb.FileController do
  use FatexWeb, :controller

  def get(conn, %{"model_id" => model_id}) do
    # FIXME:
    # wait a time to generate the file
    :timer.sleep(1000)

    conn
    |> put_resp_content_type("application/pdf")
    |> Plug.Conn.send_file(200, "maker/#{model_id}/latex.pdf")
  end
  
end
