require_relative 'lib/knight'

def main
  src = [0, 0]
  dst = [1, 1]
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
  path = [knight.dst]
  nodes = knight.board.positions
  graph = knight.board.graph
  current = nodes.index(knight.dst)
  mvs = moves(knight)
  conns = graph[current]
  mvs.reverse.each do |pos|
    if conns.include? nodes.index(pos)
      path << pos
      current = nodes.index(pos)
      conns = graph[current]
    end
  end
  path.reverse
end

def moves(knight)
  queue = [knight.src, []]
  until queue.empty?
    current = queue.shift
    visited = queue.pop
    return visited if current == knight.dst

    visited << current
    connections = knight.board.graph[knight.board.positions.index(current)]
    connections.each do |conn|
      queue << knight.board.positions[conn] unless visited.include? knight.board.positions[conn]
    end
    queue << visited
  end
end
main