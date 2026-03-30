defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "#{%StackUnderflowError{}.message}, context: #{value}"}
      end
    end
  end

  def divide([]) do
    raise StackUnderflowError.exception("when dividing")
  end

  def divide([_value]) do
    raise StackUnderflowError.exception("when dividing")
  end

  def divide([0, _value]) do
    raise DivisionByZeroError
  end

  def divide([n1, n2]), do: div(n2, n1)
end
