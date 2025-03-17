alias Trays.Repo
alias Trays.Merchant
alias Trays.ModifierGroup
alias Trays.Modifier

defmodule ModifierSeeds do
  @moduledoc false
  def add_modifier(name, modifier_group) do
    %Modifier{
      name: name,
      modifier_group_id: modifier_group.id
    }
    |> Repo.insert!()
  end

  def add_vegetarian_modifier(name, modifier_group) do
    %Modifier{
      name: name,
      vegetarian: true,
      modifier_group_id: modifier_group.id
    }
    |> Repo.insert!()
  end

  def add_vegan_modifier(name, modifier_group) do
    %Modifier{
      name: name,
      vegan: true,
      modifier_group_id: modifier_group.id
    }
    |> Repo.insert!()
  end

  def add_vegan_gluten_free_modifier(name, modifier_group) do
    %Modifier{
      name: name,
      vegan: true,
      gluten_free: true,
      modifier_group_id: modifier_group.id
    }
    |> Repo.insert!()
  end
end

apd = Repo.get!(Merchant, 1)

breakfast_sand =
  %ModifierGroup{
    name: "Breakfast Sandwich",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Cheese Omelette", breakfast_sand)
ModifierSeeds.add_vegetarian_modifier("Spinach Omelette", breakfast_sand)
ModifierSeeds.add_modifier("Bacon and cheese omelette", breakfast_sand)
ModifierSeeds.add_modifier("Ham and cheese omelette", breakfast_sand)
ModifierSeeds.add_modifier("Turkey and cheese omelette", breakfast_sand)
ModifierSeeds.add_modifier("Ham and Swiss", breakfast_sand)
ModifierSeeds.add_modifier("Turkey and Swiss", breakfast_sand)

baked_goods =
  %ModifierGroup{
    name: "Baked Goods",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Croissant", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Chocolate croissant", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Raisin roll", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Fruit danish", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Almond croissant", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Chocolate Almond croissant", baked_goods)
ModifierSeeds.add_vegetarian_modifier("Cinnamon roll", baked_goods)

muffins =
  %ModifierGroup{
    name: "Muffins",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Blueberry", muffins)
ModifierSeeds.add_vegetarian_modifier("Chocolate chip", muffins)
ModifierSeeds.add_vegetarian_modifier("Almond", muffins)
ModifierSeeds.add_vegetarian_modifier("Carrot and pineapple", muffins)
ModifierSeeds.add_vegetarian_modifier("Apricot and 5 grains", muffins)
ModifierSeeds.add_vegetarian_modifier("Raisin bran", muffins)
ModifierSeeds.add_vegetarian_modifier("Lemon and cranberry", muffins)
ModifierSeeds.add_vegan_gluten_free_modifier("Apple cinnamon", muffins)
ModifierSeeds.add_vegan_gluten_free_modifier("Double chocolate zucchini", muffins)
ModifierSeeds.add_vegan_gluten_free_modifier("Chocolate chip and banana", muffins)

minis =
  %ModifierGroup{
    name: "Mini Baked Goods",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Mini croissant", minis)
ModifierSeeds.add_vegetarian_modifier("Mini chocolate croissant", minis)
ModifierSeeds.add_vegetarian_modifier("Mini apple danish", minis)

sandwiches =
  %ModifierGroup{
    name: "Sandwiches",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Bocconcini and tomato", sandwiches)
ModifierSeeds.add_vegetarian_modifier("Grilled veggies and goat cheese", sandwiches)
ModifierSeeds.add_modifier("Chicken, bacon and tomato", sandwiches)
ModifierSeeds.add_modifier("Chicken, swiss and pesto", sandwiches)
ModifierSeeds.add_modifier("Turkey, brie and cranberries", sandwiches)
ModifierSeeds.add_modifier("Ham, brie and apple", sandwiches)
ModifierSeeds.add_modifier("Tuna nicoise on an olive ciabatta roll", sandwiches)
ModifierSeeds.add_modifier("Smoked salmon on a multigrain danish", sandwiches)
ModifierSeeds.add_modifier("Cajun chicken", sandwiches)
ModifierSeeds.add_modifier("Chicken avocado", sandwiches)
ModifierSeeds.add_modifier("Roast beef", sandwiches)


salads =
  %ModifierGroup{
    name: "Salads",
    minimum: 1,
    maximum: 1,
    merchant: apd
  }
  |> Repo.insert!()

ModifierSeeds.add_vegetarian_modifier("Beet and goat cheese", salads)
ModifierSeeds.add_vegetarian_modifier("Greek", salads)
ModifierSeeds.add_vegetarian_modifier("Lentil and vegtable", salads)
ModifierSeeds.add_vegetarian_modifier("Boiled egg and potato", salads)
ModifierSeeds.add_vegetarian_modifier("Quinoa, kale and almond", salads)
ModifierSeeds.add_vegan_modifier("Orzo and pesto", salads)
ModifierSeeds.add_vegan_gluten_free_modifier("Carrot and sunflower seed", salads)
ModifierSeeds.add_vegan_gluten_free_modifier("Kale, tomato and almond", salads)

