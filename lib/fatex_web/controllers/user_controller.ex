defmodule FatexWeb.UserController do
  use FatexWeb, :controller
  alias Fatex.Accounts
  require Logger

  # show create user
  def new(conn, _params) do
    changeset = Accounts.change_user()
    render(conn, "new.html", changeset: changeset)
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
  # Ignore the id, for security reasons, use the sesson 
  def edit(conn, %{"id" => _id}) do
    user = conn.assigns.current_user
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", changeset: changeset, user_id: user.id)
  end

  defp update_user(conn, user, old_pass, params) do
    case Accounts.verify_user(user, old_pass) do
      true ->
        Accounts.update_user(user, params)
        redirect(conn, to: "/")

      false ->
        conn
        |> put_flash(:error, "Invalid password")
        |> render("edit.html", changeset: Accounts.change_user(user), user_id: user.id)
    end
  end

  # update user
  def update(
        conn,
        %{"user" => %{
          "name" => _name,
          "password" => old_pass,
          "new_password" => "",
          "new_password_confirm" => "",
          "email" => _email
        } = params}
      ) do
    user = conn.assigns.current_user

    update_user(conn, user, old_pass, params)
  end

  def update(conn, %{"user" => %{
        "name" => _name,
        "password" => old_pass,
        "new_password" => new_pass,
        "new_password_confirm" => confirm_new_pass,
        "email" => _email
      } = params}) do
    user = conn.assigns.current_user

    case new_pass == confirm_new_pass do
      true ->
        update_user(conn, user, old_pass, Map.put(params, "password", new_pass))

      false ->
        conn
        |> put_flash(:error, "New password dont match with the password confirmation")
        |> render("edit.html", changeset: Accounts.change_user(user), user_id: user.id)
    end
  end
end
