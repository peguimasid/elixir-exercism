defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast, acc) do
    case check_op(ast) do
      nil -> {ast, acc}
      name -> {ast, [name | acc]}
    end
  end

  defp check_op({op, _metadata, [{:when, _, [{fun, _, args}, _guard]}, _body]})
       when op in [:def, :defp] do
    fun
    |> Atom.to_string()
    |> String.slice(0, length(args || []))
  end

  defp check_op({op, _metadata, [{fun, _, args}, _body]}) when op in [:def, :defp] do
    fun
    |> Atom.to_string()
    |> String.slice(0, length(args || []))
  end

  defp check_op(_), do: nil

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end
end
