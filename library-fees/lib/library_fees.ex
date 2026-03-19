defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    days_to_add = if before_noon?(checkout_datetime), do: 28, else: 29
    return_date = NaiveDateTime.add(checkout_datetime, days_to_add, :day)
    NaiveDateTime.to_date(return_date)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    max(diff, 0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)

    planned_return_date = return_date(checkout_date)
    days_late = days_late(planned_return_date, return_date)

    fee = days_late * rate

    case monday?(return_date) do
      true -> Integer.floor_div(fee, 2)
      false -> fee
    end
  end
end
