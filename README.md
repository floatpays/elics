# Elics

Parses ICalendar files.

## Installation

```elixir
def deps do
  [
    {:elics, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
iex> Elics.parse(File.read!("calendar.ics")
{:ok, 
%Elics.Vcalendar{
             events: [
               %Elics.Vevent{
                 uid: "uid1@example.com"
                 ....
               }
             ],
             version: "2.0",
             .....
           }}

```


## Todo

[]
