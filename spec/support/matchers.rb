RSpec::Matchers.define :be_a_valid_move do
  match do |actual|
    valid_letters = ('A'..'Z').to_a - ['I'] 
    number = /\d+/.match(actual)[0].to_i
    letter = /[a-zA-Z]/.match(actual)[0]
    (1..19).include?(number).should be_true
    valid_letters.include?(letter).should be_true
  end
end
