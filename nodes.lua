minetest.override_item('default:gravel', {
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
})

minetest.register_node(":default:torch", {
	description = "Torch",
	drawtype = "nodebox",
	tiles = {
		{name = "more_fire_torch_top.png"},
		{name = "more_fire_torch_bottom.png"},
		{name = "more_fire_torch_side.png"},
	},
	inventory_image = "more_fire_torch_inv.png",
	wield_image = "more_fire_torch_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX - 1,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
	},
	selection_box = {
		type = "wallmounted",
		wall_top    = {-0.1, -0.05, -0.1, 0.1, 0.5   , 0.1},
		wall_bottom = {-0.1, -0.5   , -0.1, 0.1, 0.0625, 0.1},
		wall_side   = {-0.35, -0.5  , -0.1, -0.5, 0.0625, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		if finite_torches == true then
			local timer = minetest.get_node_timer(pos)
			timer:start(960)
		end
	end,
	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = 'more_fire:torch_stub', param2 = node.param2})
		timer:stop()
	end,
})

minetest.register_node('more_fire:torch_stub', {
	description = "burnt out torch",
	drawtype = "nodebox",
	tiles = {
		{name = "more_fire_torch_stub_top.png"},
		{name = "more_fire_torch_stub_bottom.png"},
		{name = "more_fire_torch_stub_side.png"},
	},
	inventory_image = "more_fire_torch_stub_inv.png",
	wield_image = "more_fire_torch_stub_inv.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.0625, 0.2, -0.0625, 0.0625, 0.5   , 0.0625}, 
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, -0.2, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, -0.2, 0.0625},
	},
	selection_box = {
		type = "wallmounted",
		wall_top    = {-0.1, 0.2, -0.1, 0.1, 0.5   , 0.1},
		wall_bottom = {-0.1, -0.5   , -0.1, 0.1, -0.2, 0.1},
		wall_side   = {-0.35, -0.5  , -0.1, -0.5, -0.2, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),})
	
minetest.register_node('more_fire:charcoal_block', {
	description = 'Charcoal Block',
	tiles = {'more_fire_charcoal_block.png'},
	is_ground_content = true,
	groups = {oddly_breakable_by_hand=2,cracky=3,flammable=1,},
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
	groups = {dig_immediate=2, flammable=1,},
	paramtype = 'light',
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },  -- Right, Bottom, Back, Left, Top, Front
		},
	on_construct = function(pos)
	 		local meta = minetest.env:get_meta(pos)
--	 		meta:set_string('formspec', more_fire.embers_formspec)
	 		local inv = meta:get_inventory()
			inv:set_size('fuel', 4)
		end,
})

minetest.register_node('more_fire:embers', {
	description = 'Campfire',
	drawtype = 'mesh',
	mesh = 'more_fire_kindling.obj',
	tiles = {'more_fire_campfire_logs.png'},
	inventory_image = 'more_fire_campfire.png',
	wield_image = 'more_fire_campfire.png',
	walkable = false,
	is_ground_content = true,
	groups = {dig_immediate=3, flammable=1,},
	paramtype = 'light',
	drop = 'more_fire:kindling',
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			local timer = minetest.get_node_timer(pos)
			meta:set_string('formspec', more_fire.embers_formspec)
			meta:set_string('infotext', 'Campfire');
			local inv = meta:get_inventory()
			inv:set_size('fuel', 1)
			timer:start(180)
		end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
			end
			return true
		end,
	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		timer:stop()
		minetest.set_node(pos, {name = 'more_fire:kindling'})
		end,
	after_place_node = function(pos)
		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local fuel = nil
			local fuellist = inv:get_list('fuel')
			if fuellist then
				fuel = minetest.get_craft_result({method = 'fuel', width = 1, items = fuellist})
			end
		if fuel.time <= 0 then
			if inv:is_empty('fuel') then
				timer:start(180)
				end
			end
		end,
})

minetest.register_node('more_fire:campfire', {
	description = 'Burning Campfire',
	drawtype = 'mesh',
	mesh = 'more_fire_campfire.obj',
	tiles = {
		{name='fire_basic_flame_animated.png', animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1}}, {name='more_fire_campfire_logs.png'}},
	inventory_image = 'more_fire_campfire.png',
	wield_image = 'more_fire_campfire.png',
	paramtype = 'light',
	walkable = false,
	damage_per_second = 1,
	light_source = 14,
	is_ground_content = true,
	groups = {cracky=2,hot=2,attached_node=1,igniter=1,not_in_creative_inventory=1},
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	can_dig = function(pos,player)
			local meta = minetest.env:get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
				end
			return true
			end,
			get_staticdata = function(self)
end,
})

minetest.register_node('more_fire:kindling_contained', {
	description = 'Contained Kindling',
	drawtype = 'mesh',
	mesh = 'more_fire_kindling_contained.obj',
	tiles = {'more_fire_campfire_logs.png'},
	inventory_image = 'more_fire_kindling_contained.png',
	wield_image = 'more_fire_kindling.png',
	walkable = false,
	is_ground_content = true,
	groups = {dig_immediate=3,flammable=1},
	paramtype = 'light',
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
--		meta:set_string('formspec', more_fire.embers_formspec)
		local inv = meta:get_inventory()
		inv:set_size('fuel', 4)
	end,
})

minetest.register_node('more_fire:embers_contained', {
	description = 'Contained Campfire',
	drawtype = 'mesh',
	mesh = 'more_fire_kindling_contained.obj',
	tiles = {'more_fire_campfire_logs.png'},
	walkable = false,
	is_ground_content = true,
	groups = {dig_immediate=3, flammable=1, not_in_creative_inventory=1},
	paramtype = 'light',
	drop = 'more_fire:kindling_contained',
	inventory_image = 'more_fire_campfire_contained.png',
	wield_image = 'more_fire_campfire_contained.png',
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	on_construct = function(pos)
			local meta = minetest.env:get_meta(pos)
			local timer = minetest.get_node_timer(pos)
			meta:set_string('formspec', more_fire.embers_formspec)
			meta:set_string('infotext', 'Campfire');
			local inv = meta:get_inventory()
			inv:set_size('fuel', 4)
			timer:start(190)
		end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
			end
			return true
		end,
	on_timer = function(pos, elapsed)
		local timer = minetest.get_node_timer(pos)
		timer:stop()
		minetest.set_node(pos, {name = 'more_fire:kindling_contained'})
		end,
	after_place_node = function(pos)
		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local fuel = nil
			local fuellist = inv:get_list('fuel')
			if fuellist then
				fuel = minetest.get_craft_result({method = 'fuel', width = 1, items = fuellist})
			end
		if fuel.time <= 0 then
			if inv:is_empty('fuel') then
				timer:start(190)
				end
			end
end,
})

minetest.register_node('more_fire:campfire_contained', {
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
	groups = {cracky=2,hot=2,attached_node=1,dig_immediate=3,not_in_creative_inventory=1},
		selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	can_dig = function(pos,player)
			local meta = minetest.env:get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
				end
			return true
			end,
			get_staticdata = function(self)
end,
})
