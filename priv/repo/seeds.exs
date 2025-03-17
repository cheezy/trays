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
alias Trays.ProductModifier
alias Trays.Modifier
alias Trays.ModifierGroup
alias Trays.Product
alias Trays.MerchantLocation
alias Trays.Merchant
alias Trays.Accounts.User

Repo.delete_all(ProductModifier)
Repo.delete_all(Modifier)
Repo.delete_all(ModifierGroup)
Repo.delete_all(Product)
Repo.delete_all(MerchantLocation)
Repo.delete_all(Merchant)
Repo.delete_all(User)

Code.require_file("seeds/users.exs", __DIR__)
Code.require_file("seeds/merchants.exs", __DIR__)
Code.require_file("seeds/products.exs", __DIR__)
Code.require_file("seeds/modifier_groups.exs", __DIR__)
Code.require_file("seeds/product_modifiers.exs", __DIR__)


