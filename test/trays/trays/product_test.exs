defmodule Trays.ProductTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.Product
  alias Trays.ProductFixtures
  import Trays.TestHelpers

  setup do
    changeset_fn = fn attrs -> Product.changeset(%Product{}, attrs) end
    {:ok, valid_attributes: ProductFixtures.valid_product_attributes(), changeset_fn: changeset_fn}
  end

  test "should require several fields",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    valid_attributes
    |> assert_require_field(changeset_fn, :name)
    |> assert_require_field(changeset_fn, :description)
    |> assert_require_field(changeset_fn, :price)
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

  test "should allow maximum of 250 characters for a description",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :description, string_of_length(250))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :description, string_of_length(251))
    |> assert_validation_error_on(:description, "should be at most 250 character(s)")
  end

  test "should require price to be zero or greater",
       %{valid_attributes: valid_attributes, changeset_fn: changeset_fn} do
    changeset = changeset_with(changeset_fn, valid_attributes, :price, Money.new(0, :CAD))
    assert changeset.valid? == true
    changeset = changeset_with(changeset_fn, valid_attributes, :price, Money.new(1, :CAD))
    assert changeset.valid? == true

    changeset_with(changeset_fn, valid_attributes, :price, Money.new(-1, :CAD))
    |> assert_validation_error_on(:price, "must be zero or greater")
  end

end
