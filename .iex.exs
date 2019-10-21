alias Fatex.Accounts, as: A
alias Fatex.LatexConfigs, as: L
import Fatex.Repo
import Ecto.Query

user = A.get_user 1
[model | _] = L.list_models_from_user user
[step | _] = L.list_steps_from_model model
[section | _]= L.list_sections_from_step step

IO.write """
=== FOR TESTS ===
  Is defined the basic values:
  - user
  - model
  - step
  - section

  Is imported:
  - Fatex.Repo
  - Ecto.Query

  Is aliases:
  - Fatex.Accounts, as: A
  - Fatex.LatexConfigs, as: L
=================
"""
