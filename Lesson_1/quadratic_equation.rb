# Квадратное уравнение

puts 'Введите первое число:'
a = gets.chomp.to_f 
puts 'Введите второе число:'
b = gets.chomp.to_f
puts 'Введите третье число:'
c = gets.chomp.to_f

discriminant = b**2 - 4 * a * c

if discriminant < 0
  puts "дискриминант = #{discriminant}, Корней нет."

elsif discriminant == 0
  x = -b / (2 * a)
  puts "дискриминант = #{discriminant}, корень: #{x}"

elsif discriminant > 0
  x_1 = (-b + Math.sqrt(discriminant)) / (2 * a)
  x_2 = (-b - Math.sqrt(discriminant)) / (2 * a)
  puts "дискриминант = #{discriminant}, корни: #{x_1}, #{x_2}"
end

