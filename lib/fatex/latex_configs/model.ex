defmodule Fatex.LatexConfigs.Model do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step
  alias Fatex.Accounts.User

  schema "models" do
    field :name, :string

    belongs_to(:user, User)
    has_many(:steps, Step)

    timestamps()
  end

  @doc false
  def changeset(model, attrs) do
    model
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
