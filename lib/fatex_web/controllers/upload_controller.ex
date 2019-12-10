defmodule FatexWeb.UploadController do
  @moduledoc """
  Handle images upload from `FatexWeb.MenuLive`
  """

  use FatexWeb, :controller

  def create(conn, %{
        "add_image" => %{"upload" => %Plug.Upload{} = upload},
        "model_id" => model_id
      }) do
    File.cp(upload.path, "maker/#{model_id}/figures/#{upload.filename}")
    redirect(conn, to: Routes.live_path(conn, FatexWeb.ModelLive, model_id))
  end

  def create(conn, %{
        "model_id" => model_id
      }) do
    redirect(conn, to: Routes.live_path(conn, FatexWeb.ModelLive, model_id))
  end
end
