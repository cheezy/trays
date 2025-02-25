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


{:ok, cheezy} = Accounts.register_user(%{
  name: "Cheezy Morgan",
  email: "cheezy@me.com",
  password: "Apd@81Front"
})

{:ok, ardita} = Accounts.register_user(%{
  name: "Ardita Karaj",
  email: "ardita@letstango.ca",
  password: "Apd@222Bay"
})

{:ok, joseph} = Accounts.register_user(%{
  name: "Joseph Morgan",
  email: "joser.morgan6@gmail.com",
  password: "JSM@8Colborne"
})

apd = %Merchant{
  name: "Au Pain Doré",
  description: "Bakery location offering fresh bread, pastries & other sweets, plus a cafe with sandwiches & coffee.",
  contact_name: "Ardita Karaj",
  contact_phone: "4162305555",
  contact_email: "ardita@letstango.ca",
  logo_path: "/images/apd_logo.png",
  food_category: "Bakery & Cafe",
  contact_id: ardita.id
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

%Merchant{
  name: "Miku",
  description: "Flame-seared sushi is the specialty at this Japanese fine-dining destination with soaring ceilings.",
  contact_name: "Hinako Abukawa",
  contact_phone: "4165551234",
  contact_email: "ko@miku.ca",
  logo_path: "/images/miku_logo.jpg",
  food_category: "Authentic Japanese restaurant",
  contact_id: cheezy.id
}
|> Repo.insert!()

%Merchant{
  name: "The Flat Iron",
  description: "Classic British pub offering international brews & grub in a historic building with a patio.",
  contact_name: "Joseph Morgan",
  contact_phone: "6471234567",
  contact_email: "joseph@gooddrinks.ca",
  logo_path: "/images/flatiron_logo.png",
  food_category: "British Pub",
  contact_id: joseph.id
}
|> Repo.insert!()

%Merchant{
  name: "The Sultan's Tent",
  description: "French-Moroccan fare is served in the front cafe, with belly dancers & plush divans in a back room.",
  contact_name: "Livia Whynott",
  contact_phone: "6479993487",
  contact_email: "libia@sultantstent.ca",
  logo_path: "/images/sultans_tent_logo.png",
  food_category: "Mediterranean restaurant",
  contact_id: ardita.id
}
|> Repo.insert!()
