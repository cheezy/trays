defmodule Trays.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc false

  @default_logo_path "/images/logo_placeholder.jpg"

  schema "merchants" do
    field :name, :string
    field :description, :string
    field :logo_path, :string, default: @default_logo_path
    field :category, :string
    field :type, Ecto.Enum, values: [:business, :individual], default: :business

    has_many :merchant_locations, Trays.MerchantLocation
    has_many :products, Trays.Product
    belongs_to :contact, Trays.Accounts.User

    timestamps(type: :utc_datetime)
  end

  def default_logo_path() do
    @default_logo_path
  end

  @doc false
  def changeset(merchant, attrs) do
    merchant
    |> cast(attrs, [
      :name,
      :logo_path,
      :description,
      :category,
      :type,
      :contact_id
    ])
    |> validate_required([
      :name,
      :logo_path,
      :description,
      :category,
      :contact_id,
      :type
    ])
    |> validate_length(:description, min: 10, max: 500)
    |> validate_length(:name, min: 4, max: 100)
    |> validate_length(:category, min: 2, max: 100)
  end
end
