require 'currency_exception'

module CurrencyConversion

  BASE_CURRENCY = 'USD'

  def self.base_currency
    # Return a constant for now, in the future this might be an attribute
    BASE_CURRENCY
  end

  def self.exchange_rate_for_currency(currency)
    return nil if currency == BASE_CURRENCY

    rate_key = "currency.#{BASE_CURRENCY.downcase}-#{currency.downcase}"
    rate = Radiant::Config[rate_key]

    raise CurrencyException, "No rate for currency '#{currency}'" if rate.nil?
    raise CurrencyException, "Rate for currency '#{currency}' is zero" if rate.to_f < 0.1
    return rate.to_f
  end

  # Rounds to nearest 5 minus 1
  def self.snap_to_round_amount(amount)
    snap_to = 5
    sign = amount < 0 ? -1 : 1
    amount = amount.abs
    quotient, modulus = amount.divmod(snap_to)

    rounded_amount = quotient * snap_to + (modulus >= snap_to / 2.0 ? snap_to : 0)
    rounded_amount = snap_to if rounded_amount == 0
    return sign * rounded_amount - sign
  end

  def self.price_in_currency(amount, currency)
    return amount if amount.nil? or currency.upcase == base_currency

    snap_to_round_amount(amount * exchange_rate_for_currency(currency))
  end

end
