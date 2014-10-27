function burn(pointed_thing) --kindling doesn't always start from the first spark
	ignite_chance = math.random(5)
	if ignite_chance == 1 then
		minetest.env:swap_node(pointed_thing.under, {name = 'more_fire:campfire'})
	else --do nothing
	end
end

-- Copied from the 3d_torch mod, changed a few things, and removed a couple lines.
local function placeTorch(itemstack, placer, pointed_thing)
			if pointed_thing.type ~= "node" then
				return itemstack
			end

			local p0 = pointed_thing.under
			local p1 = pointed_thing.above
			local param2 = 0

			local dir = {
				x = p1.x - p0.x,
				y = p1.y - p0.y,
				z = p1.z - p0.z
			}
			param2 = minetest.dir_to_facedir(dir,false)
			local correct_rotation={
				[0]=3,
				[1]=0,
				[2]=1,
				[3]=2
			}
			if p0.y<p1.y then
			--place torch on floor
			minetest.add_node(p1, {name="more_fire:torch"})
			else
			--place torch on wall
			minetest.add_node(p1, {name="more_fire:torch_wall",param2=correct_rotation[param2]})
			--return minetest.item_place(itemstack, placer, pointed_thing, param2)
			end
			itemstack:take_item()
			return itemstack
						
end

-- abm that converts the already placed torches to the 3d ones copied from the 3d_torches mod
minetest.register_abm({
	nodenames = {"default:torch"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local convert_facedir={
			[2]=2,
			[3]=0,
			[4]=1,
			[5]=3
			
		}
		print(node.param2)
		if node.param2 == 1 then
		minetest.swap_node(pos, {name="more_fire:torch"})
		else
		minetest.swap_node(pos, {name="more_fire:torch_wall",param2=convert_facedir[node.param2]})
		end
	end,
})

-- node definitions
minetest.register_node(':default:gravel', {
	description = 'Gravel',
	tiles = {'default_gravel.png'},
	is_ground_content = true,
	groups = {crumbly=2, falling_node=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {'more_fire:flintstone'},
				rarity = 15,
			},
			{
				items = {'default:gravel'},
			}
		}
	},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.45},
	}),
})

minetest.register_node('more_fire:torch', {
	description = 'Torch',
	drawtype = 'mesh',
	mesh = 'more_fire_torch.obj',
	tiles = {'more_fire_torch.png'},
	inventory_image = 'default_torch_on_floor.png',
	wield_image = 'default_torch_on_floor.png',
	paramtype = 'light',
	paramtype2 = 'facedir',
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX-1,
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2},
	drop = 'default:torch',
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/11, -1/2, -1/11, 1/11, 1/3, 1/11},
	},
})

minetest.register_node('more_fire:torch_wall', {
	description = 'Torch',
	drawtype = 'mesh',
	mesh = 'more_fire_torch_wall.obj',
	tiles = {'more_fire_torch.png'},
	inventory_image = 'default_torch_on_floor.png',
	wield_image = 'default_torch_on_floor.png',
	paramtype = 'light',
	paramtype2 = 'facedir',
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX-1,
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2},
	drop = 'default:torch',
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
})
	
minetest.register_node('more_fire:charcoal_block', {
	description = 'Charcoal Block',
	tiles = {'default_coal_block.png'},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2,cracky=3},
})

minetest.register_node('more_fire:campfire', {
	description = 'Campfire',
	drawtype = 'mesh',
	mesh = 'more_fire_campfire.obj',
	tiles = {
		{name='fire_basic_flame_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}, {name='more_fire_campfire_logs.png'}},
	inventory_image = 'more_fire_campfire.png',
	wield_image = 'more_fire_campfire.png',
	paramtype = 'light',
	walkable = false,
	damage_per_second = 1,
	drop = 'more_fire:charcoal',
	light_source = 14,
	is_ground_content = true,
	groups = {cracky=2,hot=2,attached_node=1,dig_immediate=3,igniter=1},
})

minetest.register_node('more_fire:contained_fire', {
	description = 'Contained Campfire',
	drawtype = 'mesh',
	mesh = 'more_fire_contained_campfire.obj',
	tiles = {
		{name='fire_basic_flame_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}, {name='more_fire_campfire_logs.png'}},
	inventory_image = 'more_fire_campfire_contained.png',
	wield_image = 'more_fire_campfire_contained.png',
	paramtype = 'light',
	walkable = false,
	damage_per_second = 1,
	drop = 'more_fire:charcoal',
	light_source = 14,
	is_ground_content = true,
	groups = {cracky=2,hot=2,attached_node=1,dig_immediate=3},
})

minetest.register_node('more_fire:kindling', {
	description = 'Kindling',
	drawtype = 'mesh',
	mesh = 'more_fire_kindling.obj',
	tiles = {'more_fire_campfire_logs.png'},
	inventory_image = 'more_fire_kindling.png',
	wield_image = 'more_fire_kindling.png',
	walkable = false,
	is_ground_content = true,
	groups = {dig_immediate=3,flammable=1},
	paramtype = 'light',
})

-- craft items
minetest.register_craftitem('more_fire:charcoal', {
	description = 'Charcoal',
	inventory_image = 'more_fire_charcoal_lump.png',
	groups = {coal = 1}
})

minetest.register_craftitem('more_fire:flintstone', {
	description = 'Flintstone',
	inventory_image = 'more_fire_flintstone.png',
})

minetest.register_craftitem('more_fire:lighter', {
	description = 'Flint and Steel',
	inventory_image = 'more_fire_lighter.png',
})

-- craft recipes
minetest.register_craft({
	output = 'more_fire:charcoal_block 1',
	recipe = {
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
		{'more_fire:charcoal', 'more_fire:charcoal', 'more_fire:charcoal'},
	}
})

minetest.register_craft({
	output = 'more_fire:campfire 1',
	recipe = {
		{'', '', ''},
		{'default:stick', 'default:torch', 'default:stick'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'more_fire:contained_fire 1',
	recipe = {
		{'default:cobble', 'default:cobble', 'default:cobble'},
		{'default:cobble', 'more_fire:campfire', 'default:cobble'},
		{'default:cobble', 'default:cobble', 'default:cobble'},
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
	recipe = 'more_fire:charcoal_block',
	burntime = 315,
})

-- tools
minetest.register_tool('more_fire:lighter', {
	description = 'Lighter',
	inventory_image = 'more_fire_lighter.png',
	stack_max = 1,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 0,
		groupcaps = {
			flammable = {uses = 80, maxlevel = 1},
		}
	},
	on_use = function(itemstack, user, pointed_thing, pos)
		if pointed_thing.type == 'node'
			and string.find(minetest.get_node(pointed_thing.under).name, 'more_fire:kindling')
			then
				burn(pointed_thing)
				itemstack:add_wear(65535/80)
				return itemstack
			end
	end,
})
