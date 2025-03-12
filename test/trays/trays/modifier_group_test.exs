defmodule Trays.ModifierGroupTest do
  use Trays.DataCase

  @moduledoc false

  import Trays.TestHelpers
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierGroup

  setup do
    attrs = ModifierGroupFixtures.valid_modifier_group()
    changeset_fn = fn attrs -> ModifierGroup.changeset(%ModifierGroup{}, attrs) end
    {:ok, valid_attributes: attrs, changeset_fn: changeset_fn}
  end

  test "should require several fields",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    valid_attributes
    |> assert_require_field(changeset_fn, :name)
    |> assert_require_field(changeset_fn, :merchant_id)
  end


end
