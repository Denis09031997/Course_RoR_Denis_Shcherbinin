=begin
Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара 
(может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" 
в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, 
содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end

result = {}

loop do
  puts 'Введите название товара:'
  name_product = gets.chomp
  break if name_product == "стоп"
  puts 'Введите стоимость за штуку'
  price = gets.chomp.to_f
  puts 'Введите кол-во товара'
  quantity = gets.chomp.to_f
  result.merge!(name_product => {price: price, quantity: quantity})
end


puts "Хеш, ключами которого являются названия товаров, а значением - вложенный хеш,
содержащий цену за единицу товара и кол-во купленного товара - #{result}"

total_cost = 0

result.each do |product, details|
  puts "Общая стоимость за #{product} составит - #{details[:price] * details[:quantity]}"
  total_cost += details[:price] * details[:quantity]
end

puts "Итоговая стоимость всех покупок к оплате составит: #{total_cost}"