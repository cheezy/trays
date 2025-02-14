defmodule TraysWeb.RestoreLocale do
  @moduledoc false

  def on_mount(:default, %{"l" => locale}, _session, socket) do
    Gettext.put_locale(locale)
    TraysWeb.Cldr.put_locale(locale)

    socket =
      Phoenix.LiveView.Utils.assign(
        socket,
        :locale,
        TraysWeb.Cldr.get_my_locale()
      )

    {:cont, socket}
  end

  def on_mount(:default, _params, %{"cldr_locale" => locale}, socket) do
    Gettext.put_locale(locale)
    TraysWeb.Cldr.put_locale(locale)

    socket =
      Phoenix.LiveView.Utils.assign(
        socket,
        :locale,
        TraysWeb.Cldr.get_my_locale()
      )

    {:cont, socket}
  end

  def on_mount(:default, _params, _session, socket), do: {:cont, socket}
end
