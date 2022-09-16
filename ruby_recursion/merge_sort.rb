def merge_sort(elements)
  return elements if elements.length < 2

  first_half = elements[0..(elements.length - 1)/2]
  second_half = elements[(elements.length - 1)/2 + 1..]
  a = merge_sort(first_half)
  b = merge_sort(second_half)
  i = 0
  j = 0
  elements.each_with_index do |_elm, k|
    if b[j].nil?
      elements[k] = a[i]
      i += 1
    elsif a[i].nil?
      elements[k] = b[j]
      j += 1
    elsif a[i] < b[j]
      elements[k] = a[i]
      i += 1
    else
      elements[k] = b[j]
      j += 1
    end
  end
  elements
end

n = 2220
a = (-n..n).to_a.sample(10)
p merge_sort(a)

