defmodule Mixdown.Admin.AdminController do
  use Mixdown.Web, :controller

  def dashboard(conn, _params) do
    render(conn, "index.html")
  end

end
