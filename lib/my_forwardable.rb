module MyForwardable
  def def_delegator(receiver, method_name, method_alias = method_name)
    add_delegator(receiver, method_name, method_alias)
  end

  def def_delegators(receiver, *args)
    args.each do |arg|
      add_delegator(receiver, arg)
    end
  end

  private 

  def add_delegator(receiver, method_name, method_alias = method_name)
    define_method(method_alias) do |*args, &block|
      self.records.__send__(method_name, *args, &block)      
    end
  end
end
