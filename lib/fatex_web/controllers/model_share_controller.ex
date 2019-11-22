defmodule FatexWeb.ModelShareController do
  use FatexWeb, :controller
  alias FatexWeb.Router.Helpers
  alias Fatex.Accounts
  require Logger

  # show shared
  def show(conn, %{"id" => model_id}) do
    current_user_id = conn.assigns.current_user.id

    shares =
      Accounts.list_shared_model(current_user_id, model_id)
      |> Fatex.Repo.preload(:user)
      |> Enum.map(& &1.user)

    render(conn, "show.html", shared_with_users: shares, model_id: model_id)
  end

  # create a new shared
  def create(conn, %{"sharing" => %{"model_id" => model_id, "email_to_share" => email_to_share}}) do
    current_user_id = conn.assigns.current_user.id
    user_to_share_id = Accounts.get_user_by_email(email_to_share)
    model_id = String.to_integer(model_id)
    Accounts.share_model_with(current_user_id, model_id, user_to_share_id.id)

    conn
    |> redirect(to: Helpers.model_share_path(conn, :show, model_id))
  end

  # delete a shared
  def delete(conn, %{"model_id" => model_id, "shared_user_id" => shared_user_id}) do
    current_user_id = conn.assigns.current_user.id
    Accounts.unshare_model_with(current_user_id, model_id, shared_user_id)
    model_id = String.to_integer(model_id)

    conn
    |> redirect(to: Helpers.model_share_path(conn, :show, model_id))
  end
end
