defmodule Trays.Admin.ModifierGroupsTest do
  use Trays.DataCase

  alias Trays.Admin.ModifierGroups
  alias Trays.ModifierGroupFixtures
  alias Trays.ModifierFixtures
  alias Trays.AccountsFixtures
  alias Trays.MerchantFixtures
  alias Trays.ModifierGroup
  
  @moduledoc false

  setup do
    user = AccountsFixtures.user_fixture()
    merchant = MerchantFixtures.merchant_fixture_with_user(user)
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    modifier1 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    modifier2 = ModifierFixtures.modifier_fixture(%{modifier_group_id: modifier_group.id})
    {:ok, merchant: merchant, modifier_group: modifier_group, modifiers: [modifier1, modifier2]}
  end

  test "should retrieve a list of modifier groups",
       %{merchant: merchant, modifier_group: modifier_group} do
    [retrieved | _] = ModifierGroups.list_modifier_groups(merchant.id)

    assert retrieved.id == modifier_group.id
    assert retrieved.name == modifier_group.name
  end

  test "should retrieve a list of modifier groups with their modifiers",
       %{merchant: merchant, modifier_group: modifier_group, modifiers: modifiers} do
    [retrieved | _] = ModifierGroups.list_modifier_groups_with_modifiers(merchant.id)

    assert retrieved.id == modifier_group.id
    assert retrieved.name == modifier_group.name
    assert retrieved.modifiers == modifiers
  end

  test "should retrieve a modifier group by id", %{modifier_group: modifier_group} do
    retrieved = ModifierGroups.get_modifier_group!(modifier_group.id)
    assert retrieved.name == modifier_group.name
  end

  test "should retrieve a modifier group with its' modifiers",
      %{modifier_group: modifier_group, modifiers: modifiers} do
    retrieved = ModifierGroups.get_modifier_group_with_modifiers!(modifier_group.id)
    assert retrieved.name == modifier_group.name
    assert retrieved.modifiers == modifiers
  end

  test "should create an empty changeset for a form" do
    changeset = ModifierGroups.change_modifier_group(%ModifierGroup{})
    assert changeset.action == nil
  end

  test "should create a new modifier group", %{merchant: merchant} do
    valid_attrs = ModifierGroupFixtures.valid_modifier_group(%{merchant_id: merchant.id})
    {:ok, modifier_group} = ModifierGroups.create_modifier_group(merchant.id, valid_attrs)
    assert modifier_group.name == valid_attrs.name
    assert modifier_group.minimum == String.to_integer(valid_attrs.minimum)
    assert modifier_group.maximum == String.to_integer(valid_attrs.maximum)
    assert modifier_group.merchant_id == valid_attrs.merchant_id
  end

  test "should update a modifier group", %{modifier_group: modifier_group} do
    attrs = %{name: "updated name"}
    {:ok, updated} = ModifierGroups.update_modifier_group(modifier_group, attrs)
    assert updated.name == attrs.name
  end

  test "should delete a modifier group", %{merchant: merchant} do
    modifier_group = ModifierGroupFixtures.modifier_group_fixture(%{merchant_id: merchant.id})
    ModifierGroups.delete_modifier_group(modifier_group)
    assert Repo.get(ModifierGroup, modifier_group.id) == nil
  end
end
