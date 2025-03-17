defmodule Trays.ProductModifierTest do
  use Trays.DataCase

  @moduledoc false

  alias Trays.ProductModifier
  import Trays.TestHelpers

  setup do
    changeset_fn = fn attrs -> ProductModifier.changeset(%ProductModifier{}, attrs) end
    valid_attributes = %{price: Money.new(12), product_id: 1, modifier_id: 2}
    {:ok, valid_attributes: valid_attributes, changeset_fn: changeset_fn}
  end

  test "should require some fields", context do
    context.valid_attributes
    |> assert_require_field(context.changeset_fn, :price)
    |> assert_require_field(context.changeset_fn, :product_id)
    |> assert_require_field(context.changeset_fn, :modifier_id)
  end
end
