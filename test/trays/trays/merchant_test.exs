defmodule Trays.MerchantTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.Merchant
  alias Trays.MerchantFixtures
  import Trays.TestHelpers

  setup do
    attrs = MerchantFixtures.valid_merchant_attributes(contact_id: 1)
    changeset_fn = fn attrs -> Merchant.changeset(%Merchant{}, attrs) end
    {:ok, valid_attributes: attrs, changeset_fn: changeset_fn}
  end

  test "should require several fields",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    valid_attributes
    |> assert_require_field(changeset_fn, :name)
    |> assert_require_field(changeset_fn, :description)
    |> assert_require_field(changeset_fn, :food_category)
    |> assert_require_field(changeset_fn, :contact_id)
  end

  test "should require at least 4 characters for a name",
      %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :name, string_of_length(4))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :name, string_of_length(3))
    |> assert_validation_error_on(:name, "should be at least 4 character(s)")
  end

  test "should allow maximum of 100 characters for a name",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :name, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :name, string_of_length(101))
    |> assert_validation_error_on(:name, "should be at most 100 character(s)")
  end

  test "requires at least 10 characters for a description",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :description, string_of_length(10))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :description, string_of_length(9))
    |> assert_validation_error_on(:description, "should be at least 10 character(s)")
  end

  test "should allow maximum of 500 characters for a description",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :description, string_of_length(500))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :description, string_of_length(501))
    |> assert_validation_error_on(:description, "should be at most 500 character(s)")
  end

  test "requires at least 2 characters for a food category",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :food_category, string_of_length(2))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :food_category, string_of_length(1))
    |> assert_validation_error_on(:food_category, "should be at least 2 character(s)")
  end

  test "should allow maximum of 100 characters for a food category",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :food_category, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :food_category, string_of_length(101))
    |> assert_validation_error_on(:food_category, "should be at most 100 character(s)")
  end
end
