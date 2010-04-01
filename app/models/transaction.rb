class Transaction < ActiveRecord::Base
  def self.suggested_number(company, type)
    first(:conditions => { :company_id => company.id, :type => type },
         :order => 'created_at DESC').try(:number)
  end
end
