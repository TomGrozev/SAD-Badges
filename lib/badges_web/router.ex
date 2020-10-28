defmodule BadgesWeb.Router do
  use BadgesWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BadgesWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BadgesWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/students", StudentLive.Index, :index
    live "/students/new", StudentLive.Index, :new
    live "/students/:id/edit", StudentLive.Index, :edit

    live "/students/:id", StudentLive.Show, :show
    live "/students/:id/show/edit", StudentLive.Show, :edit

    live "/groups", GroupLive.Index, :index
    live "/groups/new", GroupLive.Index, :new
    live "/groups/:id/edit", GroupLive.Index, :edit

    live "/groups/:id", GroupLive.Show, :show
    live "/groups/:id/show/edit", GroupLive.Show, :edit

    live "/teachers", TeacherLive.Index, :index
    live "/teachers/new", TeacherLive.Index, :new
    live "/teachers/:id/edit", TeacherLive.Index, :edit

    live "/teachers/:id", TeacherLive.Show, :show
    live "/teachers/:id/show/edit", TeacherLive.Show, :edit

    live "/activities", ActivityLive.Index, :index
    live "/activities/new", ActivityLive.Index, :new
    live "/activities/:id/edit", ActivityLive.Index, :edit

    live "/activities/:id", ActivityLive.Show, :show
    live "/activities/:id/show/edit", ActivityLive.Show, :edit
    live "/activities/:id/attendance", ActivityLive.Attendance, :edit

    live "/tests", TestLive.Index, :index
    live "/tests/new", TestLive.Index, :new
    live "/tests/:test_id/edit", TestLive.Index, :edit

    live "/tests/:test_id", TestLive.Show, :show
    live "/tests/:test_id/show/edit", TestLive.Show, :edit

    live "/tests/:test_id/topics", TestLive.TopicLive.Index, :index
    live "/tests/:test_id/topics/new", TestLive.TopicLive.Index, :new
    live "/tests/:test_id/topics/:topic_id/edit", TestLive.TopicLive.Index, :edit

    live "/tests/:test_id/topics/:topic_id", TestLive.TopicLive.Show, :show
    live "/tests/:test_id/topics/:topic_id/show/edit", TestLive.TopicLive.Show, :edit

    live "/tests/:test_id/topics/:topic_id/parts", TestLive.TopicLive.PartLive.Index, :index
    live "/tests/:test_id/topics/:topic_id/parts/new", TestLive.TopicLive.PartLive.Index, :new

    live "/tests/:test_id/topics/:topic_id/parts/:part_id/edit",
         TestLive.TopicLive.PartLive.Index,
         :edit

    live "/tests/:test_id/topics/:topic_id/parts/:part_id",
         TestLive.TopicLive.PartLive.Show,
         :show

    live "/tests/:test_id/topics/:topic_id/parts/:part_id/show/edit",
         TestLive.TopicLive.PartLive.Show,
         :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BadgesWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BadgesWeb.Telemetry
    end
  end
end
