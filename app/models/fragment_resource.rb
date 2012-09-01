class FragmentResource < ActiveRecord::Base
  self.abstract_class = true
  # TODO cancellare questa classe se il polimorfismo per i modelli non fa il caso mio
  attr_accessible :description, :user_id
  
end