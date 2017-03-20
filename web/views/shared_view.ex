defmodule Mixdown.SharedView do
  use Mixdown.Web, :view

  def full_date(nil), do: nil
  def full_date(date) do
    Timex.format!(date, "{Mfull} {D}, {YYYY}")
  end
end
