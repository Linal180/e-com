class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  $global_cart = 0
  $your_cart = []

  
end
