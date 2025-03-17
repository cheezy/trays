alias Trays.Repo
alias Trays.Merchant
alias Trays.MerchantLocation
alias Trays.Accounts

debbie = Accounts.get_user_by_email("debbie@trays.ca")
mike = Accounts.get_user_by_email("mike@trays.ca")
fanny = Accounts.get_user_by_email("Fanny@trays.ca")
sally = Accounts.get_user_by_email("Sally@trays.ca")

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
  prep_time: 24,
  cancellation_policy: "24 hours before pickup",
  special_instruct: ""
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
  prep_time: 24,
  cancellation_policy: "24 hours before pickup",
  special_instruct: "Enter from Bay, then take the escalator down."
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
