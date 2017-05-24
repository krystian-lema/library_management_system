# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(username: 'lemur013', password: 'lemurek11',  email: 'krystian.lema@gmail.com', 
	first_name: 'Krystian', last_name: 'Lema', address: '-', birth_date: '1995-03-23', role: 'administrator' )
User.create(username: 'barmic', password: 'trollvbn',  email: 'barmic12@gmail.com', 
	first_name: 'Bartek', last_name: 'Michalak', address: '-', birth_date: '1995-02-15', role: 'administrator' )
User.create(username: 'student', password: 'trollvbn',  email: 'barmic12@gmail.com', 
	first_name: 'student', last_name: 'pwr', address: '-', birth_date: '1995-02-15', role: 'student' )
