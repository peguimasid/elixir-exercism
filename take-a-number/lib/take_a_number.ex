defmodule TakeANumber do
  def start() do
    spawn(&loop/0)
  end

  defp loop(current_number \\ 0) do
    receive do
      {:report_state, sender_id} ->
        send(sender_id, current_number)
        loop(current_number)

      {:take_a_number, sender_id} ->
        current_number = current_number + 1
        send(sender_id, current_number)
        loop(current_number)

      :stop ->
        Process.exit(self(), :normal)

      _ ->
        loop(current_number)
    end
  end
end
