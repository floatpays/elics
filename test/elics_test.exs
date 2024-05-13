defmodule ElicsTest do
  use ExUnit.Case
  doctest Elics

  test "parsing a simple ics file" do
    content =
      File.read!(Path.join(:code.priv_dir(:elics), "test/simple.ics"))

    assert Elics.parse(content) == %Elics.Vcalendar{
             version: "2.0",
             prodid: "-//hacksw/handcal//NONSGML v1.0//EN",
             events: [
               %Elics.Vevent{
                 uid: "uid1@example.com",
                 dtstamp: "19970714T170000Z",
                 organizer: nil,
                 dtstart: "19970714T170000Z",
                 dtend: "19970715T040000Z",
                 summary: "Bastille Day Party",
                 geo: "48.85299;2.36885"
               }
             ]
           }
  end

  test "parsing south african holidays" do
    content =
      File.read!(
        Path.join(:code.priv_dir(:elics), "test/SouthAfricaHolidays.ics")
      )

    assert %{events: [event | _]} = Elics.parse(content)

    assert event == %Elics.Vevent{
             uid: "south-africa/new-year-eve-2026",
             dtstamp: "20240401T090337Z",
             organizer: nil,
             dtstart: nil,
             dtend: nil,
             summary: "New Year's Eve",
             geo: nil
           }
  end
end
