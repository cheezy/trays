defmodule Trays.Admin.ModifiersTest do
  use Trays.DataCase

  alias Trays.Admin.Modifiers
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.Modifier

  @moduledoc false

  setup do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    {:ok, merchant: merchant, modifier_group: modifier_group, modifier: modifier}
  end

  test "should retrieve an existing modifier", %{modifier: modifier} do
    retrieved = Modifiers.get_modifier!(modifier.id)
    assert retrieved.name == modifier.name
  end

  test "should create an empty changeset for a form" do
    changeset = Modifiers.change_modifier(%Modifier{})
    assert changeset.action == nil
  end
end
