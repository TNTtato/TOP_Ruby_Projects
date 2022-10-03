require_relative 'lib/tree'
vals = Array.new(15) { rand(1..100) }
root = Tree.new(vals)

#pretty print
root.pretty_print
#Balanced?
p root.balanced?
#pre, in, post - order
root.preorder { |node| print "-> [#{node.data}] "}
puts
root.inorder { |node| print "-> [#{node.data}] "}
puts
root.postorder { |node| print "-> [#{node.data}] "}
puts
#auto rebalance
(101..110).each {|n| root.insert(n)}
root.pretty_print