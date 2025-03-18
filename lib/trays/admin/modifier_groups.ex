defmodule Trays.Admin.ModifierGroups do
  @moduledoc false

  alias Trays.Repo
  alias Trays.ModifierGroup
  import Ecto.Query

  def list_modifier_groups(merchant_id) do
    ModifierGroup
    |> where(merchant_id: ^merchant_id)
    |> Repo.all()
    |> Repo.preload(:modifiers)
  end

end
