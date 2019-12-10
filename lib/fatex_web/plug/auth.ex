defmodule FatexWeb.Plug.Auth do
  use FatexWeb, :controller
  import Plug.Conn
  alias Fatex.Accounts

  ########
  # PLUG #
  ########

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Fatex.Accounts.get_user(user_id)

    assign(conn, :current_user, user)
    |> authenticate()
  end

  defp authenticate(conn) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> Phoenix.Controller.redirect(to: "/login/new")
      |> halt()
    end
  end

  ############
  # EXTERNAL #
  ############

  # external used when creating a user
  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def login_by_email_and_pass(conn, email, given_pass) do
    user = Accounts.get_user_by_email(email)

    cond do
      user && Accounts.verify_user(user, given_pass) ->
        {:ok, login(conn, user)}

      user ->
        {:error, :unauthorized, conn}

      true ->
        # Run a dummy check, which always returns false, to make user enumeration more difficult
        Argon2.no_user_verify()
        {:error, :not_found, conn}
    end
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end
end
