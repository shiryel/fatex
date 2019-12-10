defmodule FatexWeb.Router do
  use FatexWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug FatexWeb.Plug.GenerateCSRF
  end

  pipeline :authenticate do
    plug FatexWeb.Plug.Auth
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

    # User create/update screens
    resources "/user", UserController, only: [:edit, :update]
    
    # Login screen
    # FIXME: dont find how to make a post thought the live_view
    # resources "/login", LoginController, only: [:delete]
    get "/login", LoginController, :delete

    # Send PDF to client
    get "/file/:model_id/:render_id", FileController, :get

    # Figures upload and list
    resources "/uploads/:model_id", UploadController, only: [:create]

    # Share Controller
    resources "/model_share", ModelShareController, only: [:show, :create]
    get "/model_share/:model_id/:shared_user_id", ModelShareController, :delete

    # LiveView screens and sub-screens
    live "/", HomeLive, session: [:user_id]
    live "/model/:model_id", ModelLive, session: [:user_id, :csrf_token]
    live "/model-list/:user_id", ModelListLive, session: [:user_id]
    live "/step", StepLive, session: [:step_id] 
    live "/section", SectionLive, session: [:root_section_id]
    live "/menu", MenuLive, session: [:step_id, :user_id, :csrf_token]
  end
end
