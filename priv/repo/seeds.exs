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
alias Trays.Product

{:ok, cheezy} =
  Accounts.register_user(%{
    name: "Cheezy Morgan",
    email: "cheezy@letstango.ca",
    password: "Apd@81Front",
    type: :super
  })

{:ok, ardita} =
  Accounts.register_user(%{
    name: "Ardita Karaj",
    email: "ardita@letstango.ca",
    password: "Apd@222Bay",
    type: :super
  })

{:ok, joseph} =
  Accounts.register_user(%{
    name: "Joseph Morgan",
    email: "joser.morgan6@gmail.com",
    password: "JSM@8Colborne",
    type: :super
  })

{:ok, debbie} =
  Accounts.register_user(%{
    name: "Debbie Dore",
    email: "debbie@trays.ca",
    password: "Debbie@123Pain",
    type: :merchant
  })

{:ok, mike} =
  Accounts.register_user(%{
    name: "Mike Miku",
    email: "mike@trays.ca",
    password: "Mike@123Miku",
    type: :merchant
  })

{:ok, fanny} =
  Accounts.register_user(%{
    name: "Flat Fanny",
    email: "Fanny@trays.ca",
    password: "fanny@123Iron",
    type: :merchant
  })

{:ok, sally} =
  Accounts.register_user(%{
    name: "Sally Sultan",
    email: "Sally@trays.ca",
    password: "sally@123Sultin",
    type: :merchant
  })

Accounts.register_user(%{
  name: "Curious Customer",
  email: "Customer@trays.ca",
  password: "customer@123Trays",
  type: :customer
})


apd =
  %Merchant{
    name: "Au Pain Doré",
    description:
      "Bakery location offering fresh bread, pastries & other sweets, plus a cafe with sandwiches & coffee.",
    contact_phone: "4162305555",
    logo_path: "/images/apd_logo.png",
    food_category: "Bakery & Cafe",
    contact_id: debbie.id
  }
  |> Repo.insert!()

%MerchantLocation{
  street1: "81 Front Street E",
  city: "Toronto",
  province: "ON",
  postal_code: "M5E 1B8",
  country: "Canada",
  contact_name: "Jeff Morgan",
  merchant: apd
}
|> Repo.insert!()

%MerchantLocation{
  street1: "222 Bay",
  city: "Toronto",
  province: "ON",
  postal_code: "M5K 1E5",
  country: "Canada",
  contact_name: "Ardita Karaj",
  merchant: apd
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
  merchant: apd
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
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Quiche Platter",
  description:
    "An assortment of traditional and new recipes always in a pure butter artisan pastry shell",
  category: "lunch",
  image_path: "/images/quiche.jpg",
  price: Money.new(1050),
  merchant: apd
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
  merchant: apd
}
|> Repo.insert!()

%Product{
  name: "Fruit and Cheese",
  description: "Fruit and cheese on a tray",
  category: "alacarte",
  image_path: "/images/fruit-and-cheese.jpg",
  price: Money.new(715),
  merchant: apd
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
  contact_phone: "4165551234",
  logo_path: "/images/miku_logo.jpg",
  food_category: "Authentic Japanese restaurant",
  contact_id: mike.id
}
|> Repo.insert!()

%Merchant{
  name: "The Flat Iron",
  description:
    "Classic British pub offering international brews & grub in a historic building with a patio.",
  contact_phone: "6471234567",
  logo_path: "/images/flatiron_logo.png",
  food_category: "British Pub",
  contact_id: fanny.id
}
|> Repo.insert!()

%Merchant{
  name: "The Sultan's Tent",
  description:
    "French-Moroccan fare is served in the front cafe, with belly dancers & plush divans in a back room.",
  contact_phone: "6479993487",
  logo_path: "/images/sultans_tent_logo.png",
  food_category: "Mediterranean restaurant",
  contact_id: sally.id
}
|> Repo.insert!()
