# Идеальный вес

puts 'Приветствую! Как Вас зовут?'
name = gets.chomp
puts 'Введите Ваш рост в см.'
growth = gets.chomp
result = (growth.to_i - 110) * 1.15

if result >= 0
  puts "#{name}, показатель идеального веса = #{result.to_i}."
else
  puts "Ваш вес уже оптимальный"
end