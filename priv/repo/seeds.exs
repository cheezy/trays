# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trays.Repo.insert!(%Trays.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Trays.Repo
alias Trays.Merchant
alias Trays.MerchantLocation
alias Trays.Accounts
alias Trays.Accounts.User
alias Trays.Product

Repo.delete_all(Product)
Repo.delete_all(MerchantLocation)
Repo.delete_all(Merchant)
Repo.delete_all(User)

Accounts.register_user(%{
  name: "Cheezy Morgan",
  email: "cheezy@letstango.ca",
  phone_number: "647-992-2499",
  password: "Apd@81Front",
  type: :super
})

Accounts.register_user(%{
  name: "Ardita Karaj",
  email: "ardita@letstango.ca",
  phone_number: "416-230-4519",
  password: "Apd@222Bay",
  type: :super
})

Accounts.register_user(%{
  name: "Joseph Morgan",
  email: "joser.morgan6@gmail.com",
  phone_number: "647-594-4519",
  password: "JSM@8Colborne",
  type: :super
})

{:ok, debbie} =
  Accounts.register_user(%{
    name: "Debbie Dore",
    email: "debbie@trays.ca",
    phone_number: "123-456-7890",
    password: "Debbie@123Pain",
    type: :merchant
  })

{:ok, mike} =
  Accounts.register_user(%{
    name: "Mike Miku",
    email: "mike@trays.ca",
    phone_number: "123-456-7890",
    password: "Mike@123Miku",
    type: :merchant
  })

{:ok, fanny} =
  Accounts.register_user(%{
    name: "Flat Fanny",
    email: "Fanny@trays.ca",
    phone_number: "123-456-7890",
    password: "fanny@123Iron",
    type: :merchant
  })

{:ok, sally} =
  Accounts.register_user(%{
    name: "Sally Sultan",
    email: "Sally@trays.ca",
    phone_number: "123-456-7890",
    password: "sally@123Sultin",
    type: :merchant
  })

Accounts.register_user(%{
  name: "Curious Customer",
  email: "Customer@trays.ca",
  phone_number: "123-456-7890",
  password: "customer@123Trays",
  type: :customer
})


apd =
  %Merchant{
    name: "Au Pain Doré",
    description:
      "Bakery location offering fresh bread, pastries & other sweets, plus a cafe with sandwiches & coffee.",
    logo_path: "/images/apd_logo.png",
    category: "Bakery and Cafe",
    contact_id: debbie.id,
    type: :business
  }
  |> Repo.insert!()

%MerchantLocation{
  street1: "81 Front Street E",
  city: "Toronto",
  province: "ON",
  postal_code: "M5E 1B8",
  country: "Canada",
  contact: debbie,
  merchant: apd,
  delivery_option: :pickup,
  prep_time: 24
}
|> Repo.insert!()

%MerchantLocation{
  street1: "222 Bay",
  city: "Toronto",
  province: "ON",
  postal_code: "M5K 1E5",
  country: "Canada",
  contact: debbie,
  merchant: apd,
  delivery_option: :both,
  prep_time: 24
}
|> Repo.insert!()

%Product{
  name: "Breakfast Sandwich Platter",
  description: "All served on fresh multigrain or butter croissants",
  image_path: "/images/breakfast-sandwich.jpg",
  category: "breakfast",
  price: Money.new(875),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Baked Good Platter",
  description: "And other favourites",
  image_path: "/images/baked-goods-platter.jpg",
  category: "breakfast",
  price: Money.new(575),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Muffin Platter",
  description: "Gluten free options are available",
  image_path: "/images/muffin-platter.jpg",
  category: "breakfast",
  price: Money.new(395),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Mini Baked Good Platter",
  description: "A tray of mini goodness",
  image_path: "/images/mini.jpg",
  category: "breakfast",
  price: Money.new(395),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Yogurt Parfait",
  description: "Yogurt and Fruit",
  image_path: "/images/yogurt.jpg",
  category: "breakfast",
  price: Money.new(655),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Fresh Fruit Salad",
  description: "Fruit in a cup",
  image_path: "/images/fruit.jpg",
  category: "breakfast",
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
  category: "breakfast",
  price: Money.new(1015),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Breakfast Platter",
  description: "Assortment of muffins, sweet and savoury baked goods",
  image_path: "/images/breakfast-platter.jpg",
  category: "breakfast",
  price: Money.new(575),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Sandwich Platter",
  description: "One of our amazing sandwiches",
  category: "lunch",
  image_path: "/images/sandwich.jpg",
  price: Money.new(1335),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Side Salads",
  description: "Add a salad to your sandwich order",
  category: "lunch",
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
  category: "lunch",
  image_path: "/images/quiche.jpg",
  price: Money.new(1050),
  merchant: apd,
  nut_free: true
}
|> Repo.insert!()

%Product{
  name: "French combo",
  description: "A quiche + Side salad",
  category: "lunch",
  image_path: "/images/french-combo.jpg",
  price: Money.new(1050),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Lunch Bag with desert",
  description: "Sandwich + Side salad + Cookie or fresh fruit",
  category: "lunch",
  image_path: "/images/lunch_box.jpg",
  price: Money.new(2195),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Lunch Bag without desert",
  description: "Sandwich + Side salad",
  image_path: "/images/lunch-box-without-desert.jpg",
  category: "lunch",
  price: Money.new(1995),
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Fresh Fruit",
  description: "Fruit on a Tray",
  category: "alacarte",
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
  category: "alacarte",
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
  category: "dessert",
  image_path: "/images/deserts.jpg",
  price: Money.new(495),
  merchant: apd
}
|> Repo.insert!()

%Merchant{
  name: "Miku",
  description:
    "Flame-seared sushi is the specialty at this Japanese fine-dining destination with soaring ceilings.",
  logo_path: "/images/miku_logo.jpg",
  category: "Japanese",
  contact_id: mike.id,
  type: :business
}
|> Repo.insert!()

%Merchant{
  name: "The Flat Iron",
  description:
    "Classic British pub offering international brews & grub in a historic building with a patio.",
  logo_path: "/images/flatiron_logo.png",
  category: "Pub Food",
  contact_id: fanny.id,
  type: :business
}
|> Repo.insert!()

%Merchant{
  name: "The Sultan's Tent",
  description:
    "French-Moroccan fare is served in the front cafe, with belly dancers & plush divans in a back room.",
  logo_path: "/images/sultans_tent_logo.png",
  category: "Mediterranean",
  contact_id: sally.id,
  type: :business
}
|> Repo.insert!()
