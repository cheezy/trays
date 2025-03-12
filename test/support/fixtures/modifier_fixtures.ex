defmodule Trays.ModifierFixtures do

  @moduledoc false

  alias Trays.Repo
  alias Trays.Modifier

  def unique_name, do: "Modifier #{System.unique_integer()}!"

  def valid_modifier(attrs \\ %{}) do
    Enum.into(attrs, %{
      name: unique_name(),
    })
  end

  def modifier_fixture(attrs \\ %{}) do
    {:ok, modifier} =
      %Modifier{}
      |> Modifier.changeset(valid_modifier(attrs))
      |> Repo.insert()

    modifier
  end
end



