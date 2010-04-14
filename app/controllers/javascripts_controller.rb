class JavascriptsController < ApplicationController

  def general_transaction
    @transaction_types = current_company.transaction_types
  end
  
end
