defmodule TraysWeb.PageController do
  use TraysWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    conn |> redirect(to: ~p"/#{TraysWeb.Cldr.get_my_locale()}/") |> halt()
  end
end
