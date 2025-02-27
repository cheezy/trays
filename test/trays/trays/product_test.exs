defmodule Trays.ProductTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.Product
  alias Trays.ProductFixtures
  import Trays.TestHelpers

  setup do
    {:ok, valid_attributes: ProductFixtures.valid_product_attributes()}
  end

  test "should require several fields", context do
    context.valid_attributes
    |> assert_require_field(:name)
    |> assert_require_field(:description)
    |> assert_require_field(:category)
    |> assert_require_field(:image_path)
    |> assert_require_field(:price)
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

  test "should allow maximum of 250 characters for a description", context do
    changeset = changeset_with(context.valid_attributes, :description, string_of_length(250))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :description, string_of_length(251))
    |> assert_validation_error_on(:description, "should be at most 250 character(s)")
  end

  test "requires at least 4 characters for a food category", context do
    changeset = changeset_with(context.valid_attributes, :category, string_of_length(4))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :category, string_of_length(3))
    |> assert_validation_error_on(:category, "should be at least 4 character(s)")
  end

  test "should allow maximum of 100 characters for a category", context do
    changeset = changeset_with(context.valid_attributes, :category, string_of_length(100))
    assert changeset.valid? == true

    changeset_with(context.valid_attributes, :category, string_of_length(101))
    |> assert_validation_error_on(:category, "should be at most 100 character(s)")
  end

  defp changeset_with(attrs, field, value) do
    attrs = Map.put(attrs, field, value)
    Product.changeset(%Product{}, attrs)
  end


  defp assert_require_field(valid_attrs, field) do
    invalid_attrs = Map.put(valid_attrs, field, "")
    Product.changeset(%Product{}, invalid_attrs)
    |> assert_validation_error_on(field, "can't be blank")
    valid_attrs
  end

end
