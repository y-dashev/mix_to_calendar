defmodule MixToCalendarTest do
  use ExUnit.Case
  doctest MixToCalendar
  alias MixToCalendar.URLs

  describe "google_url/1" do
    test "generates the correct Google Calendar URL" do
      calendar_event = %URLs{
        start_datetime: ~N[2024-09-19 10:00:00],
        end_datetime: ~N[2024-09-19 11:00:00],
        title: "Elixir Conference",
        timezone: "Europe/London",
        location: "123 Elixir St, London",
        description: "Join us for an amazing conference on Elixir programming!",
        url: "https://www.example.com",
        add_url_to_description: true,
        all_day: false
      }

      expected_url = "https://calendar.google.com/calendar/render?action=TEMPLATE&text=Elixir+Conference&dates=20240919T100000/20240919T110000&details=Join+us+for+an+amazing+conference+on+Elixir+programming%21+https%3A%2F%2Fwww.example.com&location=123+Elixir+St%2C+London&ctz=Europe%2FLondon"

      assert URLs.google_url(calendar_event) == expected_url
    end
  end

  describe "outlook_url/1" do
    test "generates the correct Outlook Calendar URL" do
      calendar_event = %URLs{
        start_datetime: ~N[2024-09-19 10:00:00],
        end_datetime: ~N[2024-09-19 11:00:00],
        title: "Elixir Conference",
        timezone: "Europe/London",
        location: "123 Elixir St, London",
        description: "Join us for an amazing conference on Elixir programming!",
        url: "https://www.example.com",
        add_url_to_description: true,
        all_day: false
      }

      expected_url = "https://outlook.live.com/calendar/0/deeplink/compose?path=/calendar/action/compose&subject=Elixir+Conference&startdt=2024-09-19T10:00:00&enddt=2024-09-19T11:00:00&body=Join+us+for+an+amazing+conference+on+Elixir+programming%21+https%3A%2F%2Fwww.example.com&location=123+Elixir+St%2C+London"

      assert URLs.outlook_com_url(calendar_event) == expected_url
    end
  end
end
