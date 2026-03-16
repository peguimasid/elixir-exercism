defmodule NameBadge do
  def print(id, name, department) do
    result =
      if id do
        "[#{id}] - "
      else
        ""
      end

    result = result <> "#{name} - "

    result =
      result <>
        if department do
          String.upcase(department)
        else
          "OWNER"
        end

    result
  end
end
