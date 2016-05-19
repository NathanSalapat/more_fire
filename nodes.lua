minetest.register_node(':default:torch', {
	description = 'Torch',
	drawtype = 'nodebox',
	tiles = {
		{name = 'more_fire_torch_top.png'},
		{name = 'more_fire_torch_bottom.png'},
		{name = 'more_fire_torch_side.png'},
	},
	inventory_image = 'more_fire_torch_inv.png',
	wield_image = 'more_fire_torch_inv.png',
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX - 1,
	node_box = {
		type = 'wallmounted',
		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
	},
	selection_box = {
		type = 'wallmounted',
		wall_top    = {-0.1, -0.05, -0.1, 0.1, 0.5   , 0.1},
		wall_bottom = {-0.1, -0.5   , -0.1, 0.1, 0.0625, 0.1},
		wall_side   = {-0.35, -0.5  , -0.1, -0.5, 0.0625, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2, kindling=1},
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

minetest.register_node('more_fire:torch_weak', {
	description = 'Weak Torch',
	drawtype = 'nodebox',
	tiles = {
		{name = 'more_fire_torch_top.png'},
		{name = 'more_fire_torch_bottom.png'},
		{name = 'more_fire_torch_side.png'},
	},
	inventory_image = 'more_fire_torch_inv.png',
	wield_image = 'more_fire_torch_inv.png',
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = LIGHT_MAX - 6,
	node_box = {
		type = 'wallmounted',
		wall_top    = {-0.0625, -0.0625, -0.0625, 0.0625, 0.5   , 0.0625},
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, 0.0625, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, 0.0625, 0.0625},
	},
	selection_box = {
		type = 'wallmounted',
		wall_top    = {-0.1, -0.05, -0.1, 0.1, 0.5   , 0.1},
		wall_bottom = {-0.1, -0.5   , -0.1, 0.1, 0.0625, 0.1},
		wall_side   = {-0.35, -0.5  , -0.1, -0.5, 0.0625, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2, kindling=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		if finite_torches == true then
			local timer = minetest.get_node_timer(pos)
			timer:start(480)
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
	description = 'burnt out torch',
	drawtype = 'nodebox',
	tiles = {
		{name = 'more_fire_torch_stub_top.png'},
		{name = 'more_fire_torch_stub_bottom.png'},
		{name = 'more_fire_torch_stub_side.png'},
	},
	inventory_image = 'more_fire_torch_stub_inv.png',
	wield_image = 'more_fire_torch_stub_inv.png',
	paramtype = 'light',
	paramtype2 = 'wallmounted',
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	node_box = {
		type = 'wallmounted',
		wall_top    = {-0.0625, 0.2, -0.0625, 0.0625, 0.5   , 0.0625}, 
		wall_bottom = {-0.0625, -0.5   , -0.0625, 0.0625, -0.2, 0.0625},
		wall_side   = {-0.5   , -0.5   , -0.0625, -0.375, -0.2, 0.0625},
	},
	selection_box = {
		type = 'wallmounted',
		wall_top    = {-0.1, 0.2, -0.1, 0.1, 0.5   , 0.1},
		wall_bottom = {-0.1, -0.5   , -0.1, 0.1, -0.2, 0.1},
		wall_side   = {-0.35, -0.5  , -0.1, -0.5, -0.2, 0.1},
	},
	groups = {choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, not_in_creative_inventory = 1, kindling=1},
	sounds = default.node_sound_wood_defaults(),
})
	
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
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },  
		},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('fuel', 4)
		inv:set_size("src", 1)
		inv:set_size("dst", 2)
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
	groups = {dig_immediate=3, flammable=1,not_in_creative_inventory=1},
	paramtype = 'light',
	light_source = 5,
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
			inv:set_size("src", 1)
			inv:set_size("dst", 2)
			timer:start(180)
		end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty("fuel") then
				return false
			elseif not inv:is_empty("dst") then
				return false
			elseif not inv:is_empty("src") then
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
	drop = 'more_fire:charcoal',
	groups = {cracky=2,hot=2,attached_node=1,igniter=1,not_in_creative_inventory=1},
	selection_box = {
		type = 'fixed',
		fixed = { -0.48, -0.5, -0.48, 0.48, 0.0, 0.48 },
		},
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty("fuel") then
				return false
			elseif not inv:is_empty("dst") then
				return false
			elseif not inv:is_empty("src") then
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
		local inv = meta:get_inventory()
		inv:set_size('fuel', 4)
		inv:set_size("src", 1)
		inv:set_size("dst", 2)
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
	light_source = 5,
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
			inv:set_size("src", 1)
			inv:set_size("dst", 2)
			timer:start(190)
		end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty("fuel") then
				return false
			elseif not inv:is_empty("dst") then
				return false
			elseif not inv:is_empty("src") then
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
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty("fuel") then
				return false
			elseif not inv:is_empty("dst") then
				return false
			elseif not inv:is_empty("src") then
				return false
			end
			return true
		end,
			get_staticdata = function(self)
	end,
})

minetest.register_node('more_fire:oil_lamp_on', {
	description = 'oil lamp',
	drawtype = 'mesh',
	mesh = 'more_fire_lamp_wall.obj',
	tiles = {'more_fire_lamp.png'},
	groups = {choppy=2, dig_immediate=2, not_in_creative_inventory=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	walkable = false,
	light_source = LIGHT_MAX,
	drop = 'more_fire:oil_lamp_off',
	selection_box = {
		type = 'fixed',
		fixed = {-.2, -.4, -0.1, 0.2, .35, .5},
		},
	on_timer = function(pos, itemstack)
		local node = minetest.get_node(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)
		if inv:contains_item('fuel', 'more_fire:oil') then
			local fuelstack = inv:get_stack('fuel', 1)
			timer:start(12*60)
			fuelstack:take_item()
			inv:set_stack('fuel', 1, fuelstack)
			if inv:is_empty('fuel') then
				minetest.set_node(pos, {name = 'more_fire:oil_lamp_off', param2=node.param2})
				end
				timer:stop()
		elseif inv:is_empty('fuel') then
			minetest.set_node(pos, {name = 'more_fire:oil_lamp_off', param2=node.param2})
			timer:stop()
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
})

minetest.register_node('more_fire:oil_lamp_off', {
	description = 'oil lamp',
	drawtype = 'mesh',
	mesh = 'more_fire_lamp_wall.obj',
	tiles = {'more_fire_lamp.png'},
	groups = {choppy=2, dig_immediate=2,},
	paramtype = 'light',
	paramtype2 = 'facedir',
	walkable = false,
	inventory_image = 'more_fire_lamp_inv.png',
	wield_image = 'more_fire_lamp_inv.png',
	light_source = 1,
	selection_box = {
		type = 'fixed',
		fixed = {-.2, -.4, -0.1, 0.2, .35, .5},
		},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('fuel', 1)
		meta:set_string('formspec',
			'size[8,6]'..
			'label[2,.75;Add lantern oil for a bright flame.]' ..
            'list[current_name;fuel;1,.5;1,1]'..
            'list[current_player;main;0,2;8,4;]')
		meta:set_string('infotext', 'Oil Lantern')
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)
		local node = minetest.get_node(pos)
		if inv:contains_item('fuel', 'more_fire:oil') then
			minetest.swap_node(pos, {name = 'more_fire:oil_lamp_on', param2=node.param2})
			timer:start(12*60) --one oil unit will burn for 12 minutes
			meta:set_string('infotext', 'Burning Oil Lamp')
			meta:set_string('formspec',
			'size[8,6]'..
			'label[2,.75;keep filled with lantern oil for a bright flame.]' ..
            'list[current_name;fuel;1,.5;1,1]'..
            'list[current_player;main;0,2;8,4;]')
		end
	end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
			end
			return true
		end,
})

minetest.register_node('more_fire:oil_lamp_table_on', {
	description = 'oil lamp',
	drawtype = 'mesh',
	mesh = 'more_fire_lamp_table.obj',
	tiles = {'more_fire_lamp.png'},
	groups = {choppy=2, dig_immediate=2, not_in_creative_inventory=1},
	paramtype = 'light',
	paramtype2 = 'facedir',
	walkable = false,
	light_source = LIGHT_MAX,
	drop = 'more_fire:oil_lamp_off',
	selection_box = {
		type = 'fixed',
		fixed = {-.2, -.5, -0.2, 0.2, .25, .2},
		},
	on_timer = function(pos, itemstack)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)
		if inv:contains_item('fuel', 'more_fire:oil') then
			local fuelstack = inv:get_stack('fuel', 1)
			timer:start(12*60)
			fuelstack:take_item()
			inv:set_stack('fuel', 1, fuelstack)
			if inv:is_empty('fuel') then
				minetest.set_node(pos, {name = 'more_fire:oil_lamp_table_off'})
				end
				timer:stop()
		elseif inv:is_empty('fuel') then
			minetest.set_node(pos, {name = 'more_fire:oil_lamp_table_off'})
			timer:stop()
		end
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty('fuel')
	end,
})

minetest.register_node('more_fire:oil_lamp_table_off', {
	description = 'oil lamp',
	drawtype = 'mesh',
	mesh = 'more_fire_lamp_table.obj',
	tiles = {'more_fire_lamp.png'},
	groups = {choppy=2, dig_immediate=2,},
	paramtype = 'light',
	paramtype2 = 'facedir',
	walkable = false,
	inventory_image = 'more_fire_lamp_table_inv.png',
	wield_image = 'more_fire_lamp_table_inv.png',
	light_source = 1,
	selection_box = {
		type = 'fixed',
		fixed = {-.2, -.5, -0.2, 0.2, .25, .2},
		},
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size('main', 8*4)
		inv:set_size('fuel', 1)
		meta:set_string('formspec',
			'size[8,6]'..
			'label[2,.75;Add lantern oil for a bright flame.]' ..
            'list[current_name;fuel;1,.5;1,1]'..
            'list[current_player;main;0,2;8,4;]')
		meta:set_string('infotext', 'Oil Lantern')
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.env:get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)
		if inv:contains_item('fuel', 'more_fire:oil') then
			minetest.swap_node(pos, {name = 'more_fire:oil_lamp_table_on'})
			timer:start(12*60) --one oil unit will burn for 12 minutes
			meta:set_string('infotext', 'Burning Oil Lamp')
			meta:set_string('formspec',
			'size[8,6]'..
			'label[2,.75;keep filled with lantern oil for a bright flame.]' ..
            'list[current_name;fuel;1,.5;1,1]'..
            'list[current_player;main;0,2;8,4;]')
		end
	end,
	can_dig = function(pos, player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			if not inv:is_empty('fuel') then
				return false
			end
			return true
		end,
})

