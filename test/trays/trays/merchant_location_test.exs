defmodule Trays.MerchantLocationTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.MerchantLocation
  alias Trays.MerchantLocationFixtures
  import Trays.TestHelpers

  setup do
    attrs = MerchantLocationFixtures.valid_merchant_location_attrs(merchant_id: 1)
    {:ok, valid_attributes: attrs}
  end

  test "should require several fields", context do
    context.valid_attributes
    |> assert_require_field(:street1)
    |> assert_require_field(:city)
    |> assert_require_field(:province)
    |> assert_require_field(:postal_code)
    |> assert_require_field(:country)
    |> assert_require_field(:merchant_id)
  end

  test "should require at least 3 characters for a street name", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(3))
    assert changeset.valid? == true
  end

  test "should not allow a street name to have more than 100 characters", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(101))
    assert changeset.valid? == true
  end

  test "should require a city to have at least 3 characters", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(3))
    assert changeset.valid? == true
  end

  test "should not allow a city to have more than 100 characters", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(4))
    assert changeset.valid? == true
  end

  test "should require a province to have at least 2 characters", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(4))
    assert changeset.valid? == true
  end

  test "should not allow a province to have more than 30 characters", context do
    changeset = changeset_with(context.valid_attributes, :name, string_of_length(4))
    assert changeset.valid? == true
  end

  defp assert_require_field(valid_attrs, field) do
    invalid_attrs = Map.put(valid_attrs, field, "")

    MerchantLocation.changeset(%MerchantLocation{}, invalid_attrs)
    |> assert_validation_error_on(field, "can't be blank")

    valid_attrs
  end

  defp changeset_with(attrs, field, value) do
    attrs = Map.put(attrs, field, value)
    MerchantLocation.changeset(%MerchantLocation{}, attrs)
  end
end