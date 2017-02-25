# Just a NullObject class to not have nils in the code, signifies that an AR model was supposed to be here but isn't
class NullModel
  def valid?
    false
  end
end
