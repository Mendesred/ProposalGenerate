namespace :utils do
  desc "TODO"
  task generate_admins: :environment do
    10.times do|i|
      Admin.create!( 
      	nome:Faker::Name.name,
      	email:Faker::Internet.email,
        password:"123456",
        password_confirmation:"123456",
        privilegio:1)
    end
  puts  "Admins gerandos com sucesso"
  end

end
