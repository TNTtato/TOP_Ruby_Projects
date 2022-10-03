def create_board
  board = Array.new(64) {Array.new(2)}
  .each_with_index do|pos, idx|
      pos[0] = idx / 8
      pos[1] = idx % 8
    end
end
