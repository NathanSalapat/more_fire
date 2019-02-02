local USES = 20
minetest.register_tool('more_fire:marker', {
	description = 'chard stick',
	inventory_image = 'more_fire_chard_stick.png',
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == 'node' then
				minetest.set_node(pointed_thing.above, {name = "more_fire:marking", param2=minetest.dir_to_facedir(user:get_look_dir())})
				itemstack:add_wear(65535 / (USES - 1))
				return itemstack
			end
	end,
})
