defmodule ElicsTest do
  use ExUnit.Case
  doctest Elics

  test "parsing a simple ics file" do
    content =
      File.read!(Path.join(:code.priv_dir(:elics), "test/simple.ics"))

    assert Elics.parse(content) == %Elics.Vcalendar{
             events: [
               %Elics.Vevent{
                 categories: nil,
                 class: nil,
                 description: nil,
                 dtend: ~U[1997-07-15 04:00:00Z],
                 dtstamp: ~U[1997-07-14 17:00:00Z],
                 dtstart: ~U[1997-07-14 17:00:00Z],
                 geo: "48.85299;2.36885",
                 organizer: nil,
                 summary: "Bastille Day Party",
                 uid: "uid1@example.com"
               }
             ],
             prodid: "-//hacksw/handcal//NONSGML v1.0//EN",
             version: "2.0"
           }
  end

  test "parsing south african holidays" do
    content =
      File.read!(
        Path.join(:code.priv_dir(:elics), "test/SouthAfricaHolidays.ics")
      )

    assert %{events: [event1, _, event2 | _]} = Elics.parse(content)

    assert event1 == %Elics.Vevent{
             categories: "Holidays",
             class: "public",
             description:
               "Observance - New Year’s Eve is the last day of the year\\, De cember 31\\, in the Gregorian calendar.",
             dtend: ~D[2027-01-01],
             dtstamp: ~U[2024-04-01 09:03:37Z],
             dtstart: ~D[2026-12-31],
             geo: nil,
             organizer: nil,
             summary: "New Year's Eve",
             uid: "south-africa/new-year-eve-2026"
           }

    assert event2 == %Elics.Vevent{
             categories: "Holidays",
             class: "public",
             description:
               "Season - December Solstice in South Africa (Johannesburg)",
             dtend: ~D[2026-12-22],
             dtstamp: ~U[2024-04-01 09:03:37Z],
             dtstart: ~D[2026-12-21],
             geo: nil,
             organizer: nil,
             summary: "December Solstice",
             uid: "seasons/december-solstice-2026"
           }
  end
end
