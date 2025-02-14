defmodule TraysWeb.Cldr do

    @moduledoc false

    use Cldr,
      default_locale: "en",
      locales: ["fr", "en", "de"],
      add_fallback_locales: false,
      gettext: TraysWeb.Gettext,
      data_dir: "priv/cldr",
      otp_app: :trays,
      precompile_number_formats: ["¤¤#,##0.##"],
      providers: [Cldr.Plug.PutLocale],
      generate_docs: true,
      force_locale_download: false

    def get_my_locale() do
      Cldr.get_locale().language
    end
end