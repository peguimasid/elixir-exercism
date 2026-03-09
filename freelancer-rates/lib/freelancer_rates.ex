defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8 / 1
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    daily = daily_rate(hourly_rate)
    discounted = apply_discount(daily, discount)
    trunc(Float.ceil(discounted * 22))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate = daily_rate(hourly_rate)
    discounted = apply_discount(daily_rate, discount)
    Float.floor(budget / discounted * 10) / 10
  end
end
