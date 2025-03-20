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

  test "should require at least 8 characters for a name",
      %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :name, string_of_length(8))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :name, string_of_length(7))
    |> assert_validation_error_on(:name, "should be at least 8 character(s)")
  end

  test "should allow maximum of 100 characters for a name",
      %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :name, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :name, string_of_length(101))
    |> assert_validation_error_on(:name, "should be at most 100 character(s)")
  end
end
