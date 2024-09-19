defmodule MixToCalendar.URLs do
  @moduledoc """
  Documentation for `MixToCalendar`.
  """

  @moduledoc """
  Module for generating calendar URLs for various services (Google, Yahoo, etc.).
  """

  defstruct [
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
  ]

  @tz_db Tzdata.TimeZoneDatabase

  def new(attrs) do
    %MixToCalendar.URLs{}
    |> Map.merge(attrs)
    |> validate_attributes()
  end

  def google_url(%MixToCalendar.URLs{} = calendar_event) do
    calendar_url = "https://www.google.com/calendar/render?action=TEMPLATE"
    params = %{
      text: URI.encode(calendar_event.title),
      dates: google_dates(calendar_event.start_datetime, calendar_event.end_datetime, calendar_event.all_day),
      ctz: calendar_event.timezone,
      location: URI.encode(calendar_event.location || ""),
      details: details_with_url(calendar_event)
    }

    build_url(calendar_url, params)
  end

  def yahoo_url(%MixToCalendar.URLs{} = calendar_event) do
    calendar_url = "https://calendar.yahoo.com/?v=60"
    params = %{
      title: URI.encode(calendar_event.title),
      st: format_start(calendar_event),
      dur: duration(calendar_event),
      desc: description_with_url(calendar_event),
      in_loc: URI.encode(calendar_event.location || "")
    }

    build_url(calendar_url, params)
  end

  def office365_url(calendar_event), do: microsoft_url("office365", calendar_event)

  def outlook_com_url(calendar_event), do: microsoft_url("outlook.com", calendar_event)

  defp microsoft_url(service, %MixToCalendar.URLs{} = calendar_event) do
    calendar_url =
      case service do
        "outlook.com" -> "https://outlook.live.com/calendar/0/deeplink/compose?path=/calendar/action/compose&rru=addevent"
        "office365" -> "https://outlook.office.com/calendar/0/deeplink/compose?path=/calendar/action/compose&rru=addevent"
      end

    params = %{
      subject: URI.encode(calendar_event.title),
      startdt: utc_datetime(calendar_event.start_datetime),
      enddt: utc_datetime(calendar_event.end_datetime || default_end_time(calendar_event)),
      allday: calendar_event.all_day,
      body: description_with_url(calendar_event),
      location: URI.encode(calendar_event.location || "")
    }

    build_url(calendar_url, params)
  end

  defp validate_attributes(%MixToCalendar.URLs{} = calendar_event) do
    cond do
      !is_struct(calendar_event.start_datetime, NaiveDateTime) -> raise ArgumentError, ":start_datetime must be a NaiveDateTime struct"
      calendar_event.end_datetime && calendar_event.end_datetime <= calendar_event.start_datetime -> raise ArgumentError, ":end_datetime must be greater than :start_datetime"
      calendar_event.title == "" -> raise ArgumentError, ":title must not be blank"
      true -> calendar_event
    end
  end

  defp google_dates(start_datetime, end_datetime, all_day) do
    one_day_in_seconds = 1 * 24 * 60 * 60

    cond do
      all_day && end_datetime ->
        "#{format_date(start_datetime)}/#{format_date(end_datetime + one_day_in_seconds)}"

      all_day ->
        "#{format_date(start_datetime)}/#{format_date(start_datetime + one_day_in_seconds)}"

      end_datetime ->
        "#{format_datetime_google(start_datetime)}/#{format_datetime_google(end_datetime)}"

      true ->
        "#{format_datetime_google(start_datetime)}/#{format_datetime_google(start_datetime + 60 * 60)}"
    end
  end

  defp format_start(%MixToCalendar.URLs{all_day: true, start_datetime: start_datetime}) do
    format_date(start_datetime)
  end

  defp format_start(%MixToCalendar.URLs{start_datetime: start_datetime}) do
    utc_datetime(start_datetime)
  end

  defp description_with_url(%MixToCalendar.URLs{description: description, add_url_to_description: true, url: url}) when not is_nil(description) and not is_nil(url) do
    URI.encode(description <> "\n\n" <> url)
  end

  defp description_with_url(%MixToCalendar.URLs{description: description, url: url}) when not is_nil(description) do
    URI.encode(description)
  end

  defp description_with_url(%MixToCalendar.URLs{url: url}) when not is_nil(url) do
    URI.encode(url)
  end

  defp details_with_url(%MixToCalendar.URLs{} = calendar_event) do
    if calendar_event.add_url_to_description do
      if calendar_event.description do
        URI.encode("#{calendar_event.description}\n\n#{calendar_event.url}")
      else
        URI.encode("#{calendar_event.url}")
      end
    else
      URI.encode(calendar_event.description || "")
    end
  end

  defp format_datetime_google(datetime) do
    NaiveDateTime.to_iso8601(datetime) |> String.replace(":", "") |> String.slice(0, 15)
  end

  defp utc_datetime(%NaiveDateTime{} = datetime) do
    DateTime.from_naive!(datetime, "Etc/UTC") |> DateTime.to_iso8601()
  end

  defp build_url(base_url, params) do
    Enum.reduce(params, base_url, fn {key, value}, acc ->
      acc <> "&#{key}=#{value}"
    end)
  end

  defp format_date(%NaiveDateTime{} = datetime) do
    NaiveDateTime.to_string(datetime, "{YYYY}{M}{D}")
  end

  defp default_end_time(%MixToCalendar.URLs{start_datetime: start_datetime}) do
    NaiveDateTime.add(start_datetime, 60 * 60)
  end

  defp duration(%MixToCalendar.URLs{start_datetime: start_datetime, end_datetime: end_datetime}) when not is_nil(end_datetime) do
    seconds = NaiveDateTime.diff(end_datetime, start_datetime, :second)
    format_duration(seconds)
  end

  defp duration(_), do: "0100"

  defp format_duration(seconds) do
    hours = div(seconds, 3600)
    minutes = rem(seconds, 3600) |> div(60)
    "#{pad_leading_zero(hours)}#{pad_leading_zero(minutes)}"
  end

  defp pad_leading_zero(num) when num < 10, do: "0#{num}"
  defp pad_leading_zero(num), do: "#{num}"
end
