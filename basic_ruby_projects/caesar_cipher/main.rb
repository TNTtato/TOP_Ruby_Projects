def min_max_conditions(letter)
  min_max = [65, 90] if letter.ord.between?(65, 90)
  min_max = [97, 122] if letter.ord.between?(97, 122)
  min_max
end

def make_shift(letter, shift)
  min = min_max_conditions(letter)[0]
  max = min_max_conditions(letter)[1]
  
  ord_plus_shift = letter.ord + shift
  diff = ord_plus_shift - max

  new_ord = ord_plus_shift > max ? (min + diff - 1) : ord_plus_shift
end

def new_letter(letter, shift)
  return letter unless letter.ord.between?(65,90) || letter.ord.between?(97,122)
  make_shift(letter, shift).chr
end

def caesar_cipher(text, shift_step)
  shift_step %= 26
  text.split('').map {|letter| new_letter(letter, shift_step)}.join('')
end

p caesar_cipher("Alonso WBZ", -1)
p caesar_cipher("What a string!", 5)