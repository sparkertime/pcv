Factory.define :mix do |mix|
  mix.sequence(:name) {|i| "Another Mix#{i}"}
end
