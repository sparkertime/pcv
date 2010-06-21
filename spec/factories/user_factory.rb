Factory.define :user do |user|
  user.sequence(:name) {|i| "Another User#{i}"}
  user.password "1!q"
  user.password_confirmation "1!q"
end
