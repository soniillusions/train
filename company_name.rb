# frozen_string_literal: true

module CompanyName
  attr_accessor :company_name

  def name=(name)
    @company_name = name
  end

  def show_company_name
    puts company_name.capitalize
  end
end