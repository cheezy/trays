defmodule Trays.Admin.Modifiers do

  alias Trays.Repo
  alias Trays.Modifier

  @moduledoc false

  def get_modifier!(id) do
    Repo.get!(Modifier, id)
  end

  def change_modifier(%Modifier{} = modifier, attrs \\ %{}) do
    Modifier.changeset(modifier, attrs)
  end

  def create_modifier(modifier_group_id, attrs) do
    %Modifier{modifier_group_id: modifier_group_id}
    |> Modifier.changeset(attrs)
    |> Repo.insert()
  end

  def update_modifier(%Modifier{} = modifier, attrs) do
    modifier
    |> Modifier.changeset(attrs)
    |> Repo.update()
  end

  def delete_modifier(%Modifier{} = modifier) do
    Repo.delete(modifier)
  end
end
