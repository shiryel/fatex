defmodule Fatex.Accounts.SharedModel do
  use Ecto.Schema
  import Ecto.Changeset
  alias Fatex.Accouns.User
  alias Fatex.LatexConfigs.Model

  schema "shared_models" do
    belongs_to(:user, User) 
    belongs_to(:model, Model) 

    timestamps()
  end

end
