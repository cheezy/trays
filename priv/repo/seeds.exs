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


%Merchant{
  name: "Au Pain Doré",
  description: "Amazing Bakery and Café",
  contact_name: "Ardita Karaj",
  contact_phone: "4162304519",
  contact_email: "ardita@letstango.ca",
  logo_path: "/images/apd_logo.png",
  food_category: "Bakery & Cafe",
  store_image_path: "/images/apd_store.jpg"
}
|> Repo.insert

%Merchant{
  name: "Miku",
  description: "Authentic Japanese restaurant",
  contact_name: "Joseph Morgan",
  contact_phone: "4165551234",
  contact_email: "ko@miku.ca",
  logo_path: "/images/miku_logo.jpg",
  food_category: "Japanese",
  store_image_path: "/images/miku_store.jpg"
}
|> Repo.insert