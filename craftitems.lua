
-- check if charcoal already defined by mod ethereal
if minetest.get_modpath("ethereal") then
	minetest.override_item("ethereal:charcoal_lump",{groups={coal = 1}})
	minetest.register_alias("more_fire:charcoal", "ethereal:charcoal_lump")
else
	minetest.register_craftitem('more_fire:charcoal', {
		description = 'Charcoal',
		inventory_image = 'more_fire_charcoal_lump.png',
		groups = {coal = 1}
	})
end

minetest.register_craftitem('more_fire:oil', {
	description = 'lantern oil',
	inventory_image = 'more_fire_oil.png',
})

minetest.register_craftitem('more_fire:dried_grass', {
	description = 'dried grass',
	inventory_image = 'more_fire_grass_dried.png',
	groups = {kindling=1}
})
