User.create! email: 'admin@admin.com', password: '12345678', password_confirmation: '12345678', role: 'admin'
(1..5).each do |n|
  User.create! email: "user#{n}@user.com", password: '12345678', password_confirmation: '12345678'
end