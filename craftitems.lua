minetest.register_craftitem('more_fire:charcoal', {
	description = 'Charcoal',
	inventory_image = 'more_fire_charcoal_lump.png',
	groups = {coal = 1}
})

minetest.register_craftitem('more_fire:oil', {
	description = 'lantern oil',
	inventory_image = 'more_fire_oil.png',
})

minetest.register_craftitem('more_fire:dried_grass', {
	description = 'dried grass',
	inventory_image = 'more_fire_grass_dried.png',
	groups = {kindling=1}
})

minetest.register_craftitem('more_fire:kindling', {
	description = 'Kindling',
	inventory_image = 'more_fire_kindling.png',
	groups = {flammable=1, kindling=1, stick=1}
})
