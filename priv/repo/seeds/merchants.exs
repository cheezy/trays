alias Trays.Repo
alias Trays.Merchant
alias Trays.MerchantLocation
alias Trays.Accounts
alias Trays.HoursOfDelivery

defmodule MerchantsSeeds do
  def insert_hours(day, location) do
    %HoursOfDelivery {
      day: day,
      start_time: ~T[08:00:00],
      end_time: ~T[16:00:00],
      open: true,
      merchant_location: location
    }
    |> Repo.insert!()
  end
end

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

front = %MerchantLocation{
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

MerchantsSeeds.insert_hours(:monday, front)
MerchantsSeeds.insert_hours(:tuesday, front)
MerchantsSeeds.insert_hours(:wednesday, front)
MerchantsSeeds.insert_hours(:thursday, front)
MerchantsSeeds.insert_hours(:friday, front)
MerchantsSeeds.insert_hours(:saturday, front)
MerchantsSeeds.insert_hours(:sunday, front)

bay = %MerchantLocation{
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
# add seven hours of delivery for bay
MerchantsSeeds.insert_hours(:monday, bay)
MerchantsSeeds.insert_hours(:tuesday, bay)
MerchantsSeeds.insert_hours(:wednesday, bay)
MerchantsSeeds.insert_hours(:thursday, bay)
MerchantsSeeds.insert_hours(:friday, bay)
MerchantsSeeds.insert_hours(:saturday, bay)
MerchantsSeeds.insert_hours(:sunday, bay)


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
