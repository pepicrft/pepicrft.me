defmodule PepicrftWeb.BlogController do
  use PepicrftWeb, :controller

  def show(conn, %{"year" => year, "month" => month, "day" => day, "title" => title}) do
    slug = "/blog/#{year}/#{month}/#{day}/#{title}"

    redirected_post = Pepicrft.Blog.all_posts() |> Enum.find(&(&1.redirect_from == slug))
    target_post = Pepicrft.Blog.all_posts() |> Enum.find(&(&1.slug == slug))

    cond do
      not is_nil(target_post) and is_nil(redirected_post) ->
        conn = conn |> assign(:published_time, target_post.date)
        render(conn, :show, %{post: target_post})

      not is_nil(redirected_post) ->
        redirect(conn, to: redirected_post.slug)

      true ->
        conn |> put_status(:not_found) |> halt()
    end
  end
end
