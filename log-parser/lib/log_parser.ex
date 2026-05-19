defmodule LogParser do
  def valid_line?(line) do
    Regex.match?(~r/^\[(INFO|WARNING|ERROR|DEBUG)\]/, line)
  end

  def split_line(line) do
    # Please implement the split_line/1 function
  end

  def remove_artifacts(line) do
    # Please implement the remove_artifacts/1 function
  end

  def tag_with_user_name(line) do
    # Please implement the tag_with_user_name/1 function
  end
end
