defmodule Mixdown.LayoutHelpers do
  import Phoenix.View, only: [render_existing: 3]
  import Phoenix.Controller, only: [view_module: 1, action_name: 1]

  @doc """
  ## Example

      yield("title", assigns, "My Page")

  """
  def yield(name, assigns, default \\ "") do
    assigns = Map.put(assigns, :action_name, action_name(assigns.conn))
    render_existing(view_module(assigns.conn), name, assigns) || default
  end
end
