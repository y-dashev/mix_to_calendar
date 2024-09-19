defmodule MixToCalendar do
  alias MixToCalendar.URLs
  alias MixToCalendar.Sample

  @moduledoc """
  Documentation for `MixToCalendar`.
  """

  @doc """
  Google URL

  ## Examples

      iex> MixToCalendar.google_url()
      Google Calendar URL: https://www.google.com/calendar/render?action=TEMPLATE&ctz=Europe/London&dates=2024-09-19T1000/2024-09-19T1100&details=Join%20us%20for%20an%20amazing%20conference%20on%20Elixir%20programming!%0A%0Ahttps://www.example.com&location=123%20Elixir%20St,%20London&text=Elixir%20Conference

  """
  def google_url do
    MixToCalendar.Sample.generate_google_url()
  end
end
