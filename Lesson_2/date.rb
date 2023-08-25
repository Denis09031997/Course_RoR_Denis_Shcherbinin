=begin
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). Найти порядковый номер даты,
 начиная отсчет с начала года. Учесть, что год может быть високосным. (Запрещено использовать встроенные в ruby 
  методы для этого вроде Date#yday или Date#leap?) Алгоритм опредления високосного года: docs.microsoft.com
=end

puts "Введите день: "
day = gets.chomp.to_i

puts "Введите месяц: "
month = gets.chomp.to_i

puts "Введите год: "
year = gets.chomp.to_i

leap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

days_in_month = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if leap == true
  days_in_month[2] = 29
end

counts = 0
for i in 1...month
  counts += days_in_month[i]
end
counts += day

puts "Порядковый номер даты получается - #{counts}"
