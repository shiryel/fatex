defmodule FatexWeb.UserController do
  use FatexWeb, :controller
  alias Fatex.Accounts
  require Logger

  # show create user
  def new(conn, _params) do
    changeset = Accounts.change_user()
    render(conn, "new.html", changeset: changeset )
  end

  # create user
  def create(conn, %{"user" => user}) do
    case Accounts.create_user(user) do
      {:ok, user} ->
        conn
        |> FatexWeb.Auth.login(user)
        |> redirect(to: "/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  # show update user
  # TODO
  def edit(conn, %{"id" => id}) do
    render(conn, "edit.html", user_id: id)
  end

  # update user
  # TODO
  def update(conn, params) do
    conn
  end

end
