defmodule FatexWeb.Router do
  use FatexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticate do
    plug FatexWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FatexWeb do
    pipe_through :browser

    resources "/user", UserController, only: [:new, :create]
    resources "/login", LoginController, only: [:new, :create]
  end

  scope "/", FatexWeb do
    pipe_through :browser
    pipe_through :authenticate

    resources "/user", UserController, only: [:edit, :update]
    
    # FIXME: dont find how to make a post thought the live_view
    #resources "/login", LoginController, only: [:delete]
    get "/login", LoginController, :delete

    get "/file/:model_id/:render_id", FileController, :get

    live "/", HomeLive
    live "/model/:model_id", ModelLive, session: [:user_id]
    live "/step", StepLive, session: [:step_id] 
    live "/section", SectionLive, session: [:root_section_id]
    live "/menu", MenuLive, session: [:step_id]
  end

  # Other scopes may use custom stacks.
  # scope "/api", FatexWeb do
  #   pipe_through :api
  # end
end
