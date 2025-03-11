defmodule Trays.MerchantLocationTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.MerchantLocation
  alias Trays.MerchantLocationFixtures
  import Trays.TestHelpers

  setup do
    attrs = MerchantLocationFixtures.valid_merchant_location_attrs(merchant_id: 1)
    changeset_fn = fn attrs -> MerchantLocation.changeset(%MerchantLocation{}, attrs) end
    {:ok, valid_attributes: attrs, changeset_fn: changeset_fn}
  end

  test "should require several fields", %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    valid_attributes
    |> assert_require_field(changeset_fn, :city)
    |> assert_require_field(changeset_fn, :street1)
    |> assert_require_field(changeset_fn, :province)
    |> assert_require_field(changeset_fn, :postal_code)
    |> assert_require_field(changeset_fn, :country)
    |> assert_require_field(changeset_fn, :merchant_id)
  end

  test "should require at least 3 characters for a street name",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :street1, string_of_length(3))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :street1, string_of_length(2))
    |> assert_validation_error_on(:street1, "should be at least 3 character(s)")
  end

  test "should not allow a street name to have more than 100 characters",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :street, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :street1, string_of_length(101))
    |> assert_validation_error_on(:street1, "should be at most 100 character(s)")
  end

  test "should require a city to have at least 3 characters",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :city, string_of_length(3))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :city, string_of_length(2))
    |> assert_validation_error_on(:city, "should be at least 3 character(s)")
  end

  test "should not allow a city to have more than 100 characters",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :city, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :city, string_of_length(101))
    |> assert_validation_error_on(:city, "should be at most 100 character(s)")
  end

  test "should require a province to have at least 2 characters", 
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :province, string_of_length(2))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :province, string_of_length(1))
    |> assert_validation_error_on(:province, "should be at least 2 character(s)")
  end

  test "should not allow a province to have more than 30 characters",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :province, string_of_length(30))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :province, string_of_length(31))
    |> assert_validation_error_on(:province, "should be at most 30 character(s)")
  end

  test "should require a valid postal code",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset_fn
    |> assert_is_valid_postal_code("M5E 1E1", valid_attributes)
    |> assert_is_valid_postal_code("M5E1E1", valid_attributes)
    |> assert_is_valid_postal_code("m5e1e1", valid_attributes)
    |> assert_is_valid_postal_code("m5e 1e1", valid_attributes)

    changeset_with(changeset_fn, valid_attributes, :postal_code, "m54ds3")
    |> assert_validation_error_on(:postal_code, "must be a valid postal code")
  end

  test "require Canada as the country",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :country, "Canada")
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :country, "Merica")
    |> assert_validation_error_on(:country, "Only \"Canada\" is allowed!")
  end
  
  test "require it only allows delivery options",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :delivery_option, "pickup")
    assert changeset.valid? == true
    changeset = changeset_with(changeset_fn, valid_attributes, :delivery_option, "delivery")
    assert changeset.valid? == true
    changeset = changeset_with(changeset_fn, valid_attributes, :delivery_option, "both")
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :delivery_option, "for free")
    |> assert_validation_error_on(:delivery_option, "is invalid")
  end

  test "require prep time to be between 24 hours and 336 hours",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :prep_time, 24)
    assert changeset.valid? == true
    changeset = changeset_with(changeset_fn, valid_attributes, :prep_time, 336)
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :prep_time, 23)
    |> assert_validation_error_on(:prep_time, "must be greater than 23")
    changeset_with(changeset_fn, valid_attributes, :prep_time, 337)
    |> assert_validation_error_on(:prep_time, "must be less than 337")
  end

  test "require the cancellation policy is less than 201 characters",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset_with(changeset_fn, valid_attributes, :cancellation_policy, 201)
    |> assert_validation_error_on(:cancellation_policy, "is invalid")
  end

  defp assert_is_valid_postal_code(changeset_fn, postal_code, valid_attributes) do
    changeset = changeset_with(changeset_fn, valid_attributes, :postal_code, postal_code)
    assert changeset.valid? == true
    changeset_fn
  end
end