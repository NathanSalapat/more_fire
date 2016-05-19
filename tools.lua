minetest.register_tool('more_fire:lighter', {
	description = 'Lighter',
	inventory_image = 'more_fire_lighter.png',
	stack_max = 1,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps = {
			flammable = {uses = 200, maxlevel = 1},
		}
	},
	on_use = function(itemstack, user, pointed_thing)
		minetest.sound_play("spark", {gain = 1.0, max_hear_distance = 32, loop = false })
		if pointed_thing.type == 'node'	then
			burn(pointed_thing)
			itemstack:add_wear(65535/200)
			return itemstack
		end
	end,
})

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
