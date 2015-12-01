require './user'

adele = User.create name: "Adele"
dan = User.create name: "Dan"
alan = User.create name: "Alan"

p User.all
