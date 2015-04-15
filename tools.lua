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
	on_use = function(itemstack, user, pointed_thing, pos)
		minetest.sound_play("spark", {gain = 1.0, max_hear_distance = 32, loop = false })
		if pointed_thing.type == 'node'
			and string.find(minetest.get_node(pointed_thing.under).name, 'more_fire:kindling')
			then
				burn(pointed_thing)
				itemstack:add_wear(65535/200)
				return itemstack
			end
	end,
})
