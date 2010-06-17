Factory.define :feed do |feed|
  feed.sequence(:name) {|i| "A Feed Called '#{i}'"}
  feed.sequence(:url) {|i| "something.com/#{i}" }
end