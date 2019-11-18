defmodule FatexWeb.LoginController do
  use FatexWeb, :controller
  alias Fatex.Accounts

  # show login
  def new(conn, _params) do
    changeset = Accounts.change_user()
    render(conn, "new.html", changeset: changeset )
  end

  # login
  def create(conn, %{"user" => %{"email" => email, "password" => pass}}) do
    case FatexWeb.Auth.login_by_email_and_pass(conn, email, pass) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: "/")

      {:error, _reason, conn} ->
        keep_email = Accounts.change_user(%Accounts.User{}, %{email: email})

        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html", changeset: keep_email)
    end
  end

  # logoff
  def delete(conn, _params) do
    conn
    |> FatexWeb.Auth.logout()
    |> redirect(to: "/login")
  end
end
