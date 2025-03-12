defmodule Trays.ModifierGroupFixtures do

  @moduledoc false

  alias Trays.Repo
  alias Trays.ModifierGroup

  def unique_name, do: "Modifier #{System.unique_integer()}!"
  def valid_minimum, do: "1"
  def valid_maximum, do: "2"

  def valid_modifier_group(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_name(),
      minimum: valid_minimum(),
      maximum: valid_maximum()
    })
  end

  def modifier_group_fixture(attrs \\ %{}) do
    {:ok, modifier_group} =
      %ModifierGroup{}
      |> ModifierGroup.changeset(valid_modifier_group(attrs))
      |> Repo.insert()

    modifier_group
  end
end



