defmodule Elics.Vevent do
  defstruct [
    :uid,
    :dtstamp,
    :organizer,
    :dtstart,
    :dtend,
    :summary,
    :geo,
    :class,
    :categories,
    :description
  ]
end
