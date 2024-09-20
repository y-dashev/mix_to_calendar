# mix_to_calendar
 Generating calendar URLs with elxir.

# How to use 
 MixToCalendar.Sample.generate_google_url()

 The URL should look something like this:

 https://www.google.com/calendar/render?action=TEMPLATE&location=123%20Elixir%20St,%20London&text=Elixir%20Conference&details=Join%20us%20for%20an%20amazing%20conference%20on%20Elixir%20programming!%0A%0Ahttps://www.example.com&dates=2024-09-19T1000/2024-09-19T1100&ctz=Europe/London

# Available arguments: 
  :start_datetime, 
  :end_datetime,
  :title,
  :timezone,
  :location,
  :url, 
  :description,
  :add_url_to_description,
  :all_day,
  :organizer

# Sample use 
```
  alias MixToCalendar.URLs

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

  URLs.google_url(calendar_event)

  Result: "https://www.google.com/calendar/render?action=TEMPLATE&location=123%20Elixir%20St,%20London&text=Elixir%20Conference&details=Join%20us%20for%20an%20amazing%20conference%20on%20Elixir%20programming!%0A%0Ahttps://www.example.com&dates=2024-09-19T1000/2024-09-19T1100&ctz=Europe/London"

```
