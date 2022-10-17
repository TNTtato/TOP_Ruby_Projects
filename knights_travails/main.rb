require_relative 'lib/knight'

def main
  src = [0, 0]
  dst = [1, 3]
  knight = Knight.new(src, dst)
  count = 0
  puts "Shortest Path\nStarting point --> #{src}\nEnd Point --> #{dst}\n\n"
  knight.board.positions.each do |pos|
    print "#{pos} "
    count += 1
    if count == 8
      puts
      count = 0
    end
  end
  puts
  puts "Result:"
  p knight_moves(knight)
end

def knight_moves(knight)
  path = [knight.dst]
  nodes = knight.board.positions
  graph = knight.board.graph
  current = nodes.index(knight.dst)
  mvs = moves(knight.src, knight.dst, nodes, graph)
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

def moves(src, dst, nodes, graph)
  queue = [src, []]
  until queue.empty?
    current = queue.shift
    visited = queue.pop
    return visited if current == dst

    visited << current
    connections = graph[nodes.index(current)]
    connections.each do |conn|
      queue << nodes[conn] unless visited.include? nodes[conn]
    end
    queue << visited
  end
end
main