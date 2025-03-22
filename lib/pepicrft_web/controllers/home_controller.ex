defmodule PepicrftWeb.HomeController do
  use PepicrftWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def about(conn, _params) do
    render(conn, :about)
  end

  def projects(conn, _params) do
    render(conn, :projects)
  end

  def feed(conn, _params) do
    %{body: statuses} =
      Req.get!("https://mastodon.pepicrft.me/api/v1/accounts/112887825210968145/statuses")

    render(conn, :feed, statuses: statuses)
  end

  def photos(conn, _params) do
    %{body: statuses} =
      Req.get!(
        "https://photos.pepicrft.me/api/pixelfed/v1/accounts/724674489426051073/statuses?only_media=true&min_id=1"
      )

    render(conn, :photos, statuses: statuses)
  end

  def now(conn, _params) do
    render(conn, :now)
  end
end
