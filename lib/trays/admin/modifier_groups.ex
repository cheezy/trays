defmodule Trays.Admin.ModifierGroups do
  @moduledoc false

  alias Trays.Repo
  alias Trays.ModifierGroup
  import Ecto.Query

  def list_modifier_groups(merchant_id) do
    ModifierGroup
    |> where(merchant_id: ^merchant_id)
    |> Repo.all()
  end

  def list_modifier_groups_with_modifiers(merchant_id) do
    list_modifier_groups(merchant_id)
    |> Repo.preload(:modifiers)
  end

  def get_modifier_group!(id) do
    Repo.get!(ModifierGroup, id)
  end

  def get_modifier_group_with_modifiers!(id) do
    get_modifier_group!(id) |> Repo.preload(:modifiers)
  end

  def change_modifier_group(%ModifierGroup{} = modifier_group, attrs \\ %{}) do
    ModifierGroup.changeset(modifier_group, attrs)
  end

  def create_modifier_group(merchant_id, attrs) do
    %ModifierGroup{merchant_id: merchant_id}
    |> ModifierGroup.changeset(attrs)
    |> Repo.insert()
  end

  def update_modifier_group(%ModifierGroup{} = modifier_group, attrs) do
    modifier_group
    |> ModifierGroup.changeset(attrs)
    |> Repo.update()
  end

  def delete_modifier_group(%ModifierGroup{} = modifier_group) do
    Repo.delete(modifier_group)
  end
end
