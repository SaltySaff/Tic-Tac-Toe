combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

test = ['O', 'O', 'O', 4, 5, 6, 7, 8, 9]

combinations.any? do |i|
  i.all? { |number| test[number] == 'O' }
end

# use a combination of .any .all
