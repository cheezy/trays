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
  
end
