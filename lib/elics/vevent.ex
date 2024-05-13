defmodule Elics.Vevent do
  @moduledoc false

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
