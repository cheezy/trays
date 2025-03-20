defmodule TraysWeb.Router do
  use TraysWeb, :router

  import TraysWeb.UserAuth

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
    plug :fetch_current_user
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
    end
  end

  scope "/:locale", TraysWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :admin,
        on_mount: [{TraysWeb.UserAuth, :ensure_authenticated}, {TraysWeb.RestoreLocale, :default}] do
      live "/admin/merchants", Admin.MerchantLive.Index
      live "/admin/merchants/new", Admin.MerchantLive.Form, :new
      live "/admin/merchants/:id/edit", Admin.MerchantLive.Form, :edit
      live "/admin/merchants/:id", Admin.MerchantLive.Show

      live "/admin/merchants/:merchant_id/locations/new", Admin.MerchantLocationLive.Form, :new

      live "/admin/merchants/:merchant_id/locations/:id/edit",
           Admin.MerchantLocationLive.Form,
           :edit

      live "/admin/merchants/:merchant_id/products", Admin.ProductLive.Index
      live "/admin/merchants/:merchant_id/products/new", Admin.ProductLive.Form, :new
      live "/admin/merchants/:merchant_id/products/:id/edit", Admin.ProductLive.Form, :edit

      live "/admin/merchants/:merchant_id/modifier_groups", Admin.ModifierGroupLive.Index
      live "/admin/merchants/:merchant_id/modifier_groups/new", Admin.ModifierGroupLive.Form, :new
      live "/admin/merchants/:merchant_id/modifier_groups/:id/edit", Admin.ModifierGroupLive.Form, :edit
      live "/admin/merchants/:merchant_id/modifier_groups/:id", Admin.ModifierGroupLive.Show
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

  ## Authentication routes

  scope "/:locale", TraysWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{TraysWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/:locale", TraysWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{TraysWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/:locale", TraysWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{TraysWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
