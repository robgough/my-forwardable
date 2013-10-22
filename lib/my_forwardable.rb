module MyForwardable
  def def_delegator(receiver, method_name, method_alias = method_name)
    define_method(method_alias) do |*args, &block|
      send(receiver).send(method_name, *args, &block)      
    end
  end

  def def_delegators(receiver, *methods)
    methods.each do |method|
      def_delegator(receiver, method)
    end
  end
end
