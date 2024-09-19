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

      expected_url = "https://www.google.com/calendar/render?action=TEMPLATE&ctz=Europe/London&dates=2024-09-19T1000/2024-09-19T1100&details=Join%20us%20for%20an%20amazing%20conference%20on%20Elixir%20programming!%0A%0Ahttps://www.example.com&location=123%20Elixir%20St,%20London&text=Elixir%20Conference"

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

      expected_url = "https://outlook.live.com/calendar/0/deeplink/compose?path=/calendar/action/compose&rru=addevent&allday=false&body=Join%20us%20for%20an%20amazing%20conference%20on%20Elixir%20programming!%0A%0Ahttps://www.example.com&enddt=2024-09-19T11:00:00Z&location=123%20Elixir%20St,%20London&startdt=2024-09-19T10:00:00Z&subject=Elixir%20Conference"

      assert URLs.outlook_com_url(calendar_event) == expected_url
    end
  end
end
