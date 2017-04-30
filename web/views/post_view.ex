defmodule Mixdown.PostView do
  use Mixdown.Web, :view

  def md_to_html(markdown) do
    markdown
    |> Earmark.as_html!(%Earmark.Options{code_class_prefix: "lang- language-"})
    |> raw
  end

  def full_date(nil), do: nil
  def full_date(date), do: Timex.format!(date, "{Mfull} {D}, {YYYY}")

  def render("title", %{post: post}) do
    post.title
  end
  def render("title", %{posts: _posts}) do
    "All the posts!"
  end
end
