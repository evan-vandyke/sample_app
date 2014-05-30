FactoryGirl.define do 
	factory :user do
		name	"Evan VanDyke"
		email	"test@gmail.com"
		password "foobar"
		password_confirmation "foobar"
	end
end