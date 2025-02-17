defmodule Trays.Admin.Merchants do

    @moduledoc false

  alias Trays.Repo
  alias Trays.Merchant

  def list_merchants() do
    Merchant
    |> Repo.all()
  end

  def get_merchant!(id) do
      Repo.get!(Merchant, id)
  end
end