defmodule MixToCalendar do
  alias MixToCalendar.Sample

  @moduledoc """
  Documentation for `MixToCalendar`.
  """

  @doc """
  Google URL

  ## Examples

      iex> MixToCalendar.google_url()

  """
  def google_url do
    MixToCalendar.Sample.generate_google_url()
  end

  def yahoo_url do
    MixToCalendar.Sample.generate_yahoo_url()
  end
end
