# frozen_string_literal: true

# в этом модуле располагаются различные методы-хелперы
module HelperMethods
  def each_show(arr)
    arr.each_with_index do |el, i|
      puts "#{i} - #{el}"
    end
  end
end
