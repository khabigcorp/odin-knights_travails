def is_valid(coordinate)
  return coordinate[0] >= 0 && coordinate[0] < 8 && coordinate[1] >= 0 && coordinate[1] < 8
end

def knight_moves(start, stop)
  queue = [start]
  squares = Array.new(64, -1)
  visited = Array.new(64, false)
  transforms = [[1, 2], [1, -2], [2, 1], [2, -1], [-1, 2], [-1, -2], [-2, -1], [-2, 1]]
  until queue.empty? || visited[stop[0] * 8 + stop[1]] == true do
    current_square = queue.first
    for transform in transforms do
      transformed_square = [current_square[0] + transform[0], current_square[1] + transform[1]]
      if is_valid(transformed_square) && !visited[transformed_square[0] * 8 + transformed_square[1]] && transformed_square != start
        squares[transformed_square[0] * 8 + transformed_square[1]] = current_square[0] * 8 + current_square[1]
        visited[transformed_square[0] * 8 + transformed_square[1]] = true
        queue.append(transformed_square)
      end
    end
    queue.shift
  end

  previous_square = squares[stop[0] * 8 + stop[1]]
  moves = []
  until previous_square == -1 do
    moves.append(previous_square)
    previous_square = squares[previous_square]
  end 

  moves = moves.map { |item| [item / 8, item % 8]}
  moves = moves.reverse()
  moves.push(stop)
  return moves
end

puts "Input coordinates of starting point (format: <x_coordinate> <y_coordinate>):"
start = gets.chomp.split.map(&:to_i)
puts "Input coordinates of ending point (format: <x_coordinate> <y_coordinate>):"
stop = gets.chomp.split.map(&:to_i)
p knight_moves(start, stop)