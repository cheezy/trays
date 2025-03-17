alias Trays.Repo
alias Trays.Product
alias Trays.Merchant

apd = Repo.get!(Merchant, 1)

%Product{
  name: "Breakfast Sandwich Platter",
  description: "All served on fresh multigrain or butter croissants",
  image_path: "/images/breakfast-sandwich.jpg",
  category: "Breakfast",
  price: Money.new(875),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Baked Good Platter",
  description: "And other favourites",
  image_path: "/images/baked-goods-platter.jpg",
  category: "Breakfast",
  price: Money.new(575),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Muffin Platter",
  description: "Gluten free options are available",
  image_path: "/images/muffin-platter.jpg",
  category: "Breakfast",
  price: Money.new(395),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Mini Baked Good Platter",
  description: "A tray of mini goodness",
  image_path: "/images/mini.jpg",
  category: "Breakfast",
  price: Money.new(395),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Yogurt Parfait",
  description: "Yogurt and Fruit",
  image_path: "/images/yogurt.jpg",
  category: "Breakfast",
  price: Money.new(655),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Fresh Fruit Salad",
  description: "Fruit in a cup",
  image_path: "/images/fruit.jpg",
  category: "Breakfast",
  price: Money.new(635),
  merchant: apd,
  vegan: true,
  vegetarian: true,
  nut_free: true,
  gluten_free: true
}
|> Repo.insert!()

%Product{
  name: "Breakfast Combo",
  description: "Baked Good or Muffin + Yogurt Pafait or Fruit Salad",
  image_path: "/images/breakfast-combo.jpg",
  category: "Breakfast",
  price: Money.new(1015),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Breakfast Platter",
  description: "Assortment of muffins, sweet and savoury baked goods",
  image_path: "/images/breakfast-platter.jpg",
  category: "Breakfast",
  price: Money.new(575),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Sandwich Platter",
  description: "One of our amazing sandwiches",
  category: "Lunch",
  image_path: "/images/sandwich.jpg",
  price: Money.new(1335),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Side Salads",
  description: "Add a salad to your sandwich order",
  category: "Lunch",
  image_path: "/images/salad.jpg",
  price: Money.new(625),
  merchant: apd,
  vegetarian: true
}
|> Repo.insert!()

%Product{
  name: "Quiche Platter",
  description:
    "An assortment of traditional and new recipes always in a pure butter artisan pastry shell",
  category: "Lunch",
  image_path: "/images/quiche.jpg",
  price: Money.new(1050),
  merchant: apd,
  nut_free: true
}
|> Repo.insert!()

%Product{
  name: "French combo",
  description: "A quiche + Side salad",
  category: "Lunch",
  image_path: "/images/french-combo.jpg",
  price: Money.new(1050),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Lunch Bag with desert",
  description: "Sandwich + Side salad + Cookie or fresh fruit",
  category: "Lunch",
  image_path: "/images/lunch_box.jpg",
  price: Money.new(2195),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Lunch Bag without desert",
  description: "Sandwich + Side salad",
  image_path: "/images/lunch-box-without-desert.jpg",
  category: "Lunch",
  price: Money.new(1995),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Fresh Fruit",
  description: "Fruit on a Tray",
  category: "À La Carte",
  image_path: "/images/fruit_platter.jpg",
  price: Money.new(655),
  merchant: apd,
  vegan: true,
  vegetarian: true,
  nut_free: true,
  gluten_free: true
}
|> Repo.insert!()

%Product{
  name: "Fruit and Cheese",
  description: "Fruit and cheese on a tray",
  category: "À La Carte",
  image_path: "/images/fruit-and-cheese.jpg",
  price: Money.new(715),
  merchant: apd,
  vegetarian: true,
  nut_free: true
}
|> Repo.insert!()

%Product{
  name: "Dessert Platter",
  description: "A tray with a lot of deserts",
  category: "Dessert",
  image_path: "/images/deserts.jpg",
  price: Money.new(495),
  merchant: apd
}
|> Repo.insert!()
