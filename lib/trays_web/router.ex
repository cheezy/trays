defmodule TraysWeb.Router do
  use TraysWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session

    plug Cldr.Plug.PutLocale,
      apps: [:cldr, :gettext],
      from: [:query, :path, :body, :cookie, :accept_language],
      param: "locale",
      gettext: TraysWeb.Gettext,
      cldr: TraysWeb.Cldr

    plug Cldr.Plug.PutSession, as: :string
    plug :fetch_live_flash
    plug :put_root_layout, html: {TraysWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :mounted_apps do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TraysWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", TraysWeb do
  #   pipe_through :api
  # end

  live_session :default, on_mount: TraysWeb.RestoreLocale do
    scope "/:locale", TraysWeb do
      pipe_through :browser
      live "/", TraysLive.Index
      live "/trays", TraysLive.Index

      live "/admin/merchants", Admin.MerchantLive.Index
      live "/admin/merchants/:id", Admin.MerchantLive.Show
    end
  end

  scope "/feature-flags" do
    pipe_through :mounted_apps
    forward "/", FunWithFlags.UI.Router, namespace: "feature-flags"
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:trays, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TraysWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
