defmodule Trays.MerchantTest do
  use Trays.DataCase
  
  @moduledoc false

  alias Trays.Merchant
  alias Trays.MerchantFixtures
  import Trays.TestHelpers

  setup do
    attrs = MerchantFixtures.valid_merchant_attributes(contact_id: 1)
    {:ok, valid_attributes: attrs}
  end

  test "should require several fields", context do
    context.valid_attributes
    |> assert_require_field(:name)
    |> assert_require_field(:description)
    |> assert_require_field(:food_category)
    |> assert_require_field(:contact_id)
  end

  test "should require at least 4 characters for a name", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(4))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :name, string_of_length(3))
    |> assert_validation_error_on(:name, "should be at least 4 character(s)")
  end

  test "should allow maximum of 100 characters for a name", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :name, string_of_length(101))
    |> assert_validation_error_on(:name, "should be at most 100 character(s)")
  end

  test "requires at least 10 characters for a description", context do
    changeset = changeset_with(context.valid_attributes, :description, string_of_length(10))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :description, string_of_length(9))
    |> assert_validation_error_on(:description, "should be at least 10 character(s)")
  end

  test "should allow maximum of 500 characters for a description", context do
    changeset = changeset_with(context.valid_attributes, :description, string_of_length(500))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :description, string_of_length(501))
    |> assert_validation_error_on(:description, "should be at most 500 character(s)")
  end

  test "requires at least 2 characters for a food category", context do
    changeset = changeset_with(context.valid_attributes, :food_category, string_of_length(2))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :food_category, string_of_length(1))
    |> assert_validation_error_on(:food_category, "should be at least 2 character(s)")
  end

  test "should allow maximum of 100 characters for a food category", context do
    changeset = changeset_with(context.valid_attributes, :food_category, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :food_category, string_of_length(101))
    |> assert_validation_error_on(:food_category, "should be at most 100 character(s)")
  end

  defp changeset_with(attrs, field, value) do
    attrs = Map.put(attrs, field, value)
    Merchant.changeset(%Merchant{}, attrs)
  end

  defp assert_require_field(valid_attrs, field) do
    invalid_attrs = Map.put(valid_attrs, field, "")
    changeset = Merchant.changeset(%Merchant{}, invalid_attrs)
    assert changeset.valid? == false
    assert Keyword.keys(changeset.errors) == [field]
    valid_attrs
  end

end
