defmodule Fatex.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Fatex.Repo
  alias Fatex.Accounts.User
  
  #########
  # Users #
  #########

  @doc """
  Returns the list of users.

  ## Examples

      iex> result = list_users()
      iex> with [user | _] <- result,
      ...>      %Fatex.Accounts.User{} <- user, do: :ok
      :ok
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> result = get_user(1)
      iex> with %Fatex.Accounts.User{} <- result, do: :ok
      :ok

      iex> get_user(213812)
      nil
  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Gets a single user with email info

  ## Examples

      iex> result = get_user_by_email("vinicius_molina@hotmail.com")
      iex> with %Fatex.Accounts.User{} <- result, do: :ok
      :ok

      iex> get_user_by_email("haha")
      nil
  """
  def get_user_by_email(email) do
    Repo.all(
      from u in User,
        where: u.email == ^email
    )
    |> List.first()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> with result = create_user(%{name: "jubileu", email: "jubileu@hotmail.com", password: "hash_secret"}),
      ...>      {:ok, %User{}} <- result, do: :ok
      :ok

      iex> with result <- create_user(%{field: "asdkj"}),
      ...> {:error, %Ecto.Changeset{}} <- result, do: :ok
      :ok
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> u = get_user 1
      iex> with result = update_user(u, %{name: "jubileu"}),
      ...>      {:ok, %User{name: "jubileu"}} <- result, do: :ok
      :ok
  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.registration_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Verify the password using the Argon2


  ## Examples

      iex> a = Fatex.Accounts.list_users |> List.first
      iex> Fatex.Accounts.verify_user a, "t"
      false
      iex> Fatex.Accounts.verify_user a, nil
      false
      iex> Fatex.Accounts.verify_user a, "test"
      true
  """
  def verify_user(%User{} = user, password) do
    case Argon2.check_pass(user, password) do
      {:ok, _user} ->
        true
      {:error, _reason} ->
        false
    end
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> with {:ok, user} = create_user(%{name: "jubileu", email: "jubileu@hotmail.com", password: "hash_secret"}),
      ...>      {:ok, %User{}} <- delete_user(user), do: :ok
      :ok
  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

  iex> with %Ecto.Changeset{} <- change_user(%User{}), do: :ok
  :ok

  """
  def change_user() do
    User.changeset(%User{}, %{})
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def change_user(%User{} = user, params) do
    User.changeset(user, params)
  end

  #################
  # Shared Models #
  #################

  @doc """
  List all users who a module is shared with
  This checks if he model is from the user, for use on controller

  ## Example:
  
      # with the initial seed 0 users a model shared with
      iex> list_shared_model(1, 1)
      []

      # do not share with yourself
      iex> share_model_with(1,1,1)
      iex> list_shared_model(1, 1)
      []

      # share a model and list the users who the model is shared
      iex> share_model_with(1,1,2)
      iex> list_shared_model(1, 1)
      [2]
  """
  def list_shared_model(user_id, model_id) do
    # TODO
    []
  end


  @doc """
  Share a model with a user
  This checks if he model is from the user, for use on controller

  ## Examples:

      # do not share with yourself
      iex> share_model_with(1,1,1)
      iex> list_shared_model(1, 1)
      []

      # share a model and list the users who the model is shared
      iex> share_model_with(1,1,2)
      iex> list_shared_model(1, 1)
      [2]
  """
  def share_model_with(user_id, model_id, shared_user_id) do
    # TODO
    []
  end

  @doc """
  Unshare a model with a user
  This checks if he model is from the user, for use on controller

  ## Examples:

      # do not unshare with yourself
      iex> unshare_model_with(1,1,1)
      iex> list_shared_model(1, 1)
      []

      # share a model, list the users who the model is shared and unshare the model
      iex> share_model_with(1,1,2)
      iex> list_shared_model(1, 1)
      [2]
      iex> unshare_model_with(1,1,2)
      iex> list_shared_model(1, 1)
      []
  """
  def unshare_model_with(user_id, model_id, shared_user_id) do
    # TODO
    []
  end
end
