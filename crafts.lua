minetest.register_craft({
	output = 'more_fire:charcoal_block 1',
	recipe = {
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
	}
})

minetest.register_craft({
	output = 'more_fire:charcoal 9',
	recipe = {
		{'more_fire:charcoal_block'}
	}
})

minetest.register_craft({
	output = 'more_fire:embers 1',
	recipe = {
		{'more_fire:kindling'},
		{'default:torch'},
	}
})

minetest.register_craft({
	output = 'more_fire:embers 1',
	recipe = {
		{'group:kindling', 'default:torch', 'group:kindling'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'more_fire:embers 1',
	recipe = {
		{'group:flammable', 'default:torch', 'group:flammable'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'more_fire:embers_contained 1',
	recipe = {
		{'', 'more_fire:embers', ''},
		{'default:cobble', 'default:cobble', 'default:cobble'},
	}
})

minetest.register_craft({
	output = 'more_fire:embers_contained 1',
	recipe = {
		{'more_fire:kindling_contained'},
		{'default:torch'},
	}
})

minetest.register_craft({
	output = 'more_fire:torch_weak 4',
	recipe = {
		{'group:kindling', 'group:kindling', 'group:kindling'},
		{'group:kindling', 'group:stick', 'group:kindling'},
		{'', 'group:stick', ''}
	}
})

minetest.register_craft({
	type = 'shapeless',
	output = 'default:torch',
	recipe = {'more_fire:torch_weak', 'group:coal'},
})

minetest.register_craft({
	type = 'shapeless',
	output = 'more_fire:kindling 1',
	recipe = {'group:kindling', 'group:wood', 'group:kindling', 'group:kindling', 'group:kindling'},
})

minetest.register_craft({
	type = 'shapeless',
	output = 'more_fire:kindling 1',
	recipe = {'group:flammable', 'group:wood', 'group:flammable', 'group:flammable', 'group:flammable'},
})

minetest.register_craft({
	output = 'more_fire:kindling_contained 1',
	recipe = {
		{'','more_fire:kindling', ''},
		{'default:cobble','default:cobble','default:cobble'},
		}
})

minetest.register_craft({
		output = 'more_fire:oil_lamp_off 1',
		recipe = {
		{'default:glass'},
		{'farming:cotton'},
		{'default:iron_lump'},
		}
})

minetest.register_craft({
		output = 'more_fire:oil 1',
		recipe = {
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'group:leaves', 'group:leaves', 'group:leaves'},
		{'', 'vessels:glass_bottle', ''},
		}
})

minetest.register_craft({
	output = 'more_fire:oil_lamp_off 1',
	recipe = {
		{'more_fire:oil_lamp_table_off'}
	}
})

minetest.register_craft({
	output = 'more_fire:oil_lamp_table_off 1',
	recipe = {
		{'more_fire:oil_lamp_off'}
	}
})

minetest.register_craft({
	output = 'more_fire:lighter',
	recipe = {
		{'','','group:wood'},
		{'','default:flint',''},
		{'default:steel_ingot','',''},
	}
})

-- cooking recipes
minetest.register_craft({
	type = 'cooking',
	recipe = 'group:tree',
	output = 'more_fire:charcoal',
})

minetest.register_craft({
	type = 'cooking',
	recipe = 'default:grass_1',
	output = 'more_fire:dried_grass',
	cooktime = 1,
})

-- fuel recipes
minetest.register_craft({
	type = 'fuel',
	recipe = 'more_fire:charcoal',
	burntime = 35,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'more_fire:oil',
	burntime = 10,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'more_fire:charcoal_block',
	burntime = 315,
})

minetest.register_craft({
	type = 'fuel',
	recipe = 'more_fire:torch_stub',
	burntime = 2,
})
