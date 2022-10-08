require_relative 'lib/knight'

def main
  src = [0, 0]
  dst = [3, 1]
  knight = Knight.new(src, dst)
  count = 0
  knight.board.positions.each do |pos|
    print "#{pos} "
    count += 1
    if count == 8
      puts
      count = 0
    end
  end
  puts
  p knight_moves(knight)
end

def knight_moves(knight)
  queue = [knight.src, []]
  until queue.empty?
    current = queue.shift
    visited = queue.pop
    return visited if current == knight.dst

    visited << current
    connections = knight.board.graph[knight.board.positions.index(current)]
    connections.each {|conn| queue << knight.board.positions[conn] unless visited.include? knight.board.positions[conn]}
    queue << visited
  end
end

main