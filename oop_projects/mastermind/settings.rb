require_relative 'forms_and_colors'

module Settings
  def self.color_hash
    {
      '1' => FAC.colorize(FAC.filled_circle, :red),
      '2' => FAC.colorize(FAC.filled_circle, :blue),
      '3' => FAC.colorize(FAC.filled_circle, :green),
      '4' => FAC.colorize(FAC.filled_circle, :yellow),
      '5' => FAC.colorize(FAC.filled_circle, :cyan),
      '6' => FAC.colorize(FAC.filled_circle, :magenta),
      '7' => FAC.colorize(FAC.filled_circle, :white)
    }
  end

  def self.gen_pos
    base = (1111..6666).to_a
    base_s = base.map { |num| num.to_s }
    base_s_n = base_s.select do |num|
      num.split('').any? { |n| n.to_i > 6 || n.to_i.zero? }
    end
    base_s -= base_s_n
    base_s
  end
end