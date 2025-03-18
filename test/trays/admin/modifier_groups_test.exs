defmodule Trays.Admin.ModifierGroupsTest do
  use Trays.DataCase

  alias Trays.Admin.ModifierGroups
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  
  @moduledoc false

  setup do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier1 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    modifier2 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    {:ok, merchant: merchant, modifier_group: modifier_group, modifiers: [modifier1, modifier2]}
  end

  test "should retrieve a list of modifier groups with their modifiers",
       %{merchant: merchant, modifier_group: modifier_group, modifiers: modifiers} do
    [retrieved | _] = ModifierGroups.list_modifier_groups(merchant.id)

    assert retrieved.id == modifier_group.id
    assert retrieved.name == modifier_group.name
    assert retrieved.modifiers == modifiers
  end
end
