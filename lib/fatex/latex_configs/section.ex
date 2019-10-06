defmodule Fatex.LatexConfigs.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.LatexConfigs.Step

  schema "sections" do
    field :name, :string
    field :content, :string

    field :type, :string

    field :child_id, :integer
    field :pos_child_id, :integer
    field :pre_child_id, :integer

    belongs_to(:step, Step)

    timestamps()
  end

  def changeset(model, attrs) do
    model
    |> cast(attrs, ~w[name content type child_id pos_child_id pre_child_id]a)
    |> validate_required(~w[name content type]a)
  end
  
end
