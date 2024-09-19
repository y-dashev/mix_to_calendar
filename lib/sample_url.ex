defmodule MixToCalendar.Sample do
  alias MixToCalendar.URLs

  def generate_google_url do
    start_datetime = ~N[2024-09-19 10:00:00]
    end_datetime = ~N[2024-09-19 11:00:00]
    title = "Elixir Conference"
    timezone = "Europe/London"
    location = "123 Elixir St, London"
    description = "Join us for an amazing conference on Elixir programming!"
    url = "https://www.example.com"
    add_url_to_description = true
    all_day = false

    calendar_event = %URLs{
      start_datetime: start_datetime,
      end_datetime: end_datetime,
      title: title,
      timezone: timezone,
      location: location,
      description: description,
      url: url,
      add_url_to_description: add_url_to_description,
      all_day: all_day
    }

    google_url = URLs.google_url(calendar_event)

    IO.puts("Google Calendar URL: #{google_url}")
  end


  def generate_yahoo_url do
    start_datetime = ~N[2024-09-19 10:00:00]
    end_datetime = ~N[2024-09-19 11:00:00]
    title = "Elixir Conference"
    timezone = "Europe/London"
    location = "123 Elixir St, London"
    description = "Join us for an amazing conference on Elixir programming!"
    url = "https://www.example.com"
    add_url_to_description = true
    all_day = false

    calendar_event = %URLs{
      start_datetime: start_datetime,
      end_datetime: end_datetime,
      title: title,
      timezone: timezone,
      location: location,
      description: description,
      url: url,
      add_url_to_description: add_url_to_description,
      all_day: all_day
    }

    yahoo_url = URLs.yahoo_url(calendar_event)

    IO.puts("Yahoo Calendar URL: #{yahoo_url}")
  end
end
