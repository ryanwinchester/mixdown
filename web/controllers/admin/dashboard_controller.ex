defmodule Mixdown.Admin.DashboardController do
  use Mixdown.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

end
