def fibs(n)
  result = []
  n1 = 1
  n2 = 0
  for i in (0..n-1)
    result[i] = n2
    n2, n1 = n2 + n1, n2
  end
  result
end

# From n = 14 forward, the computation time becomes a nightmare
def fibs_rec(n, result = [])
  (0..n-1).each {|i| i < 2 ? result << i : result << (fibs_rec(i)[-1] + fibs_rec(i)[-2])}
  result
end

p fibs_rec(15)

