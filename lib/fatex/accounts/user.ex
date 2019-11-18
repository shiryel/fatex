defmodule Fatex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Model

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many(:models, Model) 
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    put_change(changeset, :password_hash, Argon2.add_hash(pass)[:password_hash])
  end
  defp put_pass_hash(changeset), do: changeset
end
