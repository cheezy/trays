defmodule Trays.Merchants do

  @moduledoc """
  The Merchants context.
  """

  alias Trays.Repo
  alias Trays.Merchant

  def list_merchants() do
    Merchant
    |> Repo.all()
  end


end
