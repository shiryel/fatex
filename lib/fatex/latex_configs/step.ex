defmodule Fatex.LatexConfigs.Step do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.{Section, Model}

  schema "steps" do
    field :name, :string
    has_many(:sections, Section)
    belongs_to(:model, Model)

    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, ~w[name]a)
    |> validate_required(~w[name]a)
  end
end
