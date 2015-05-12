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
		{'', '', ''},
		{'default:stick', 'default:torch', 'default:stick'},
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
	output = 'default:torch 4',
	recipe = {
		{'more_fire:charcoal'},
		{'group:stick'},
	}
})

minetest.register_craft({
	type = 'shapeless',
	output = 'more_fire:kindling 1',
	recipe = {'group:stick', 'group:wood', 'group:flammable', 'group:flammable'},
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
	type = 'shapeless',
	output = 'more_fire:lighter 1',
	recipe = {'more_fire:flintstone', 'default:steel_ingot'}
})

-- cooking recipes
minetest.register_craft({
	type = 'cooking',
	recipe = 'group:tree',
	output = 'more_fire:charcoal',
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
