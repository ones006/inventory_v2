# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def prawn_header
    pdf.text "Header"
  end
end
