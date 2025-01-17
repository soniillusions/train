# frozen_string_literal: true

module HelperMethods
  def each_show(arr)
    arr.each_with_index do |el, i|
      puts "#{i} - #{el}"
    end
  end
end
