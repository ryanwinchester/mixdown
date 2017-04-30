defmodule Mixdown.LayoutHelpers do
  import Phoenix.View, only: [render_existing: 3]
  import Phoenix.Controller, only: [view_module: 1]

  @doc """
  ## Example

      yield(assigns, :title, "My Page")

  """
  def yield(assigns, name, default \\ "") do
    render_existing(view_module(assigns.conn), to_string(name), assigns) || default
  end
end
