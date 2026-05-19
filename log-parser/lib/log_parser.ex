defmodule LogParser do
  def valid_line?(line) do
    Regex.match?(~r/^\[(INFO|WARNING|ERROR|DEBUG)\]/, line)
  end

  def split_line(line) do
    String.split(line, ~r/<[~\*\=\-]*>/)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/, line) do
      [_, user_name] ->
        "[USER] #{user_name} #{line}"

      _ ->
        line
    end
  end
end
