# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

mikes = Shelter.create(name: "Mike's Shelter", address: '1331 17th Street', city: 'Denver', state: 'CO', zip: '80202')
megs = Shelter.create(name: "Meg's Shelter", address: '150 Main Street', city: 'Hershey', state: 'PA', zip: '17033')

athena = Pet.create(image: "https://image.shutterstock.com/image-photo/funny-studio-portrait-smilling-puppy-600w-1008869716.jpg", name: "Athena", age: "1", sex: "Female", description: "Butthead", status: "adoptable", shelter_id: mikes.id)
odell = Pet.create(image: "https://image.shutterstock.com/image-photo/dog-600w-587562362.jpg", name: "Odell", age: "4", sex: "Male", description: "good dog", status: "adoptable", shelter_id: megs.id)
