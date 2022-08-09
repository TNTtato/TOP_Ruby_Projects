def substrings(text, dictionary)

  result = Hash.new(0)
  under_case_text = text.downcase
  matches_array = dictionary.map {|word| under_case_text.scan(word)}
  matches_array.delete([])
  matches_array.each {|sub_array| result[sub_array[0]] = sub_array.length}
  p result
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

substrings("Howdy partner, sit down! How's it going?", dictionary)
