def bubble_sort(arr)
  temp_arr = arr[0..-1]
  for jdx in (0..arr.length-2) do
    for idx in (0..arr.length-2) do
      if temp_arr[idx] > temp_arr[idx + 1]
        temp_arr[idx], temp_arr[idx + 1] = temp_arr[idx + 1], temp_arr[idx]
      end
    end
  end
  temp_arr
end
p bubble_sort([4,3,78,2,0,2])

p bubble_sort([1,4,7,2,3,9,22,4,2,1,5,7,3,2,9,10,11])