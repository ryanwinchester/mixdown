defmodule Mixdown.PostView do
  use Mixdown.Web, :view

  def render("title", %{post: post}) do
    post.title
  end

  def md_to_html(markdown) do
    markdown
    |> Earmark.as_html!(%Earmark.Options{code_class_prefix: "lang- language-"})
    |> raw
  end

  def full_date(nil), do: nil
  def full_date(date) do
    Timex.format!(date, "{Mfull} {D}, {YYYY}")
  end

end
