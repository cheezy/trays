defmodule Trays.Admin.Merchants do

    @moduledoc false

#    alias Trays.Repo
#  alias Trays.Merchant

  def list_merchants() do
    [
      %Trays.Merchant{
        id: 1,
        name: "Au Pain Doré",
        description: "Amazing Bakery and Café",
        contact_name: "Ardita Karaj",
        contact_phone: "4162304519",
        contact_email: "ardita@letstango.ca",
        logo_path: "/images/apd_logo.png",
        food_category: "Bakery & Cafe",
        store_image_path: "/images/apd_store.jpg"
      },
      %Trays.Merchant{
        id: 2,
        name: "Miku",
        description: "Authentic Japanese restaurant",
        contact_name: "Ko Ko",
        contact_phone: "4165551234",
        contact_email: "ko@miku.ca",
        logo_path: "/images/miku_logo.jpg",
        food_category: "Japanese",
        store_image_path: "/images/miku_store.jpg"
      }
    ]
  end
end