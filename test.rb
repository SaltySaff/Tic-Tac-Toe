COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8]].freeze

test = ['X', 'O', 'X', 'O', 5, 6, 'X', 'O', 'X']

result = COMBINATIONS.any? do |i|
  i.all? { |element| test[element] == 'X' }
end
p result
# use a combination of .any .all

test_two = ['X', 1, 2]

(test_two.any? { |element| element == 'X' })
