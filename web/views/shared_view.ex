defmodule Mixdown.SharedView do
  use Mixdown.Web, :view

  def full_date(nil), do: nil
  def full_date(date) do
    Timex.format!(date, "{Mfull} {D}, {YYYY}")
  end

  @doc """
  Check if there are any alerts flashed.
  """
  def has_alert(conn) do
    has_info(conn) or has_error(conn) or has_success(conn)
  end

  @doc """
  Check if there are any info alerts.
  """
  def has_success(conn) do
    get_flash(conn, :success) !== nil
  end

  @doc """
  Check if there are any info alerts.
  """
  def has_info(conn) do
    get_flash(conn, :info) !== nil
  end

  @doc """
  Check if there are any error alerts.
  """
  def has_error(conn) do
    get_flash(conn, :error) !== nil
  end

end
