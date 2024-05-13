defmodule Elics.ValueParser do
  @moduledoc false

  import NimbleParsec

  def parse_timestamp(val) do
    {:ok, [year, month, day, hour, minute, second], _, _, _, _} =
      parse_datetime(val)

    time = Time.new!(hour, minute, second)
    date = Date.new!(year, month, day)

    DateTime.new!(date, time)
  end

  def parse("VALUE=DATE", val) do
    {:ok, [year, month, day], _, _, _, _} = parse_date(val)

    Date.new!(year, month, day)
  end

  def parse(_format, val) do
    val
  end

  date =
    integer(4)
    |> integer(2)
    |> integer(2)

  time =
    integer(2)
    |> integer(2)
    |> integer(2)

  defparsecp(:parse_date, date)

  defparsecp(:parse_datetime, date |> ignore(string("T")) |> concat(time))
end
