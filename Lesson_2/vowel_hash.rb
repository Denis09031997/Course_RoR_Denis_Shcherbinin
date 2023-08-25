# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1)

vowels = ['А', 'Е', 'И', 'О', 'У', 'Ы', 'Э', 'Ю', 'Я']
result = {}

range = ('А'..'Я')
i = 1

for char in range
  if vowels.include?(char)
    result[char.to_sym] = i
  end
  i += 1
end

p result