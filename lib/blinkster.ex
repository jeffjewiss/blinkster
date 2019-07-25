defmodule Blinkster do
  @moduledoc """
  Documentation for Blinkster.
  """

  @message "hello world"

  require Logger

  def start(_type, _args) do
    led_list = Application.get_env(:blinkster, :led_list)
    Logger.debug("list of leds to blink is #{inspect(led_list)}")
    spawn(fn -> blink_message_forever(led_list) end)
    {:ok, self()}
  end

  defp blink_message_forever(led_list) do
    Enum.each(led_list, fn led ->
      Blinkster.Morse.play(led, @message)
      Blinkster.Morse.play(led, "/////") # a gap between messages
    end)

    blink_message_forever(led_list)
  end
end
