# Admin user
admin = User.find_or_create_by(email: "admin@cookbook.com") do |u|
  u.username              = "admin"
  u.display_name          = "Admin"
  u.password              = "admin1"
  u.password_confirmation = "admin1"
end

puts "Admin created: #{admin.email}" if admin.persisted?
