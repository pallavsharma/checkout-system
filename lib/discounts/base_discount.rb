class BaseDiscount

  def apply(args={})
    should_discount_be_applied?(args[:order]) ? apply_discount(args) : 0
  end

  private

  def should_discount_be_applied?
    raise NotImplementedError
  end

  def apply_discount(args={})
    raise NotImplementedError
  end
end
