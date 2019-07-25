defmodule Blinkster.Morse do
  @moduledoc """
  Uses the LED module and converts a morse code text string into a series
  of flashing led lights.

  # Legend
  Dit: 1 unit
  Dah: 3 units
  Intra-character space (the gap between dits and dahs within a character): 1 unit
  Inter-character space (the gap between the characters of a word): 3 units
  Word space (the gap between two words): 7 units
  """

  @tick 200

  alias Nerves.Leds
  require Logger

  @doc """
  Take a string of morse code and "play" it using the LED.
  """
  def play(led_key, string) when is_binary(string) do
    string
    |> Morse.encode()
    |> String.codepoints()
    |> Enum.each(fn char -> blink(led_key, char) end)
  end

  @doc """
  Blinks the LED based on the character.
  """
  def blink(led_key, char) when is_binary(char) do
    cond do
      char == "." ->
        on(led_key, 1)
        off(led_key, 1)
      char == "-" ->
        on(led_key, 3)
        off(led_key, 1)
      char == " " ->
        off(led_key, 2)
      char == "/" ->
        off(led_key, 6)
      true ->
        Logger.error("unrecognized character #{char}")
    end
  end

  defp on(led_key, ticks) when is_number(ticks) do
    Logger.debug "turning led #{inspect led_key} on"
    Leds.set([{led_key, true}])
    :timer.sleep(@tick * ticks)
  end

  defp off(led_key, ticks) when is_number(ticks) do
    Logger.debug "turning led #{inspect led_key} off"
    Leds.set([{led_key, false}])
    :timer.sleep(@tick * ticks)
  end
end
