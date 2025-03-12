defmodule Trays.ModifierTest do
  use Trays.DataCase

  @moduledoc false

  import Trays.TestHelpers
  alias Trays.ModifierFixtures
  alias Trays.Modifier

  setup do
    attrs = ModifierFixtures.valid_modifier()
    changeset_fn = fn attrs -> Modifier.changeset(%Modifier{}, attrs) end
    {:ok, valid_attributes: attrs, changeset_fn: changeset_fn}
  end

  test "should require several fields",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    valid_attributes
    |> assert_require_field(changeset_fn, :name)
    |> assert_require_field(changeset_fn, :modifier_group_id)
  end


end
