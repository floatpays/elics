defmodule Elics do
  alias Elics.{Vcalendar, Vevent}

  def parse(content) do
    String.split(content, ~r/(\r\n|\r|\n)/, trim: true)
    |> parse_body()
  end

  defp parse_body(["BEGIN:VCALENDAR" | lines]) do
    parse_vcalendar(lines, %Vcalendar{events: []})
  end

  defp parse_vcalendar(["END:VCALENDAR" | _], %Vcalendar{} = calendar) do
    calendar
  end

  defp parse_vcalendar(["BEGIN:VEVENT" | lines], %Vcalendar{} = calendar) do
    parse_vevent(lines, calendar, %Vevent{})
  end

  defp parse_vcalendar([line | lines], %Vcalendar{} = calendar) do
    {key, val, lines} = get_key_val([line | lines])

    case vcalendar_keys(key) do
      {:ok, key_atom} ->
        parse_vcalendar(lines, %{calendar | key_atom => val})

      :error ->
        parse_vcalendar(lines, calendar)
    end
  end

  defp parse_vevent(
         ["END:VEVENT" | lines],
         %Vcalendar{} = calendar,
         %Vevent{} = event
       ) do
    parse_vcalendar(lines, %{calendar | events: [event | calendar.events]})
  end

  defp parse_vevent(
         ["ORGANIZER;" <> _ | lines],
         %Vcalendar{} = calendar,
         %Vevent{} = event
       ) do
    parse_vevent(lines, calendar, event)
  end

  defp parse_vevent(
         [line | lines],
         %Vcalendar{} = calendar,
         %Vevent{} = event
       ) do
    {key, val, lines} = get_key_val([line | lines])

    case vevent_keys(key) do
      {:ok, key_atom} ->
        parse_vevent(lines, calendar, %{event | key_atom => val})

      :error ->
        parse_vevent(lines, calendar, event)
    end
  end

  defp get_key_val([line | lines]) do
    [key, val] = String.split(line, ":")

    # the value might span multiple lines
    {val, lines} = parse_val(val, lines)

    {key, val} =
      case String.split(key, ";") do
        [key, format] ->
          {key, Elics.ValueParser.parse(format, val)}

        [key] ->
          case key do
            "DTSTAMP" ->
              {key, Elics.ValueParser.parse_timestamp(val)}

            _ ->
              {key, val}
          end
      end

    {key, val, lines}
  end

  defp parse_val(val, [" " <> val_cont | lines]) do
    parse_val(val <> " " <> val_cont, lines)
  end

  defp parse_val(val, [line | lines]) do
    {val, [line | lines]}
  end

  for key <- Map.keys(%Elics.Vevent{}) do
    defp vevent_keys(unquote(to_string(key) |> String.upcase())),
      do: {:ok, unquote(key)}
  end

  defp vevent_keys(_), do: :error

  for key <- Map.keys(%Elics.Vcalendar{}) do
    defp vcalendar_keys(unquote(to_string(key) |> String.upcase())),
      do: {:ok, unquote(key)}
  end

  defp vcalendar_keys(_), do: :error
end
