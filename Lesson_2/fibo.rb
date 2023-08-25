# Заполнить массив числами фибоначчи до 100

fibonacci_numbers = [0, 1]

while (next_number = fibonacci_numbers[-1] + fibonacci_numbers[-2]) < 100
  fibonacci_numbers.push(next_number)
end

p fibonacci_numbers
