minetest.register_abm({  -- Controls non-contained fire
	nodenames = {'more_fire:embers','more_fire:campfire'},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
		'fuel_totaltime',
		'fuel_time',
		}) do
		if meta:get_string(name) == '' then
			meta:set_float(name, 5.0)
			end
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local was_active = false
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			was_active = true
			meta:set_float('fuel_time', meta:get_float('fuel_time') + 0.25)
			end
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			minetest.sound_play({name='fire_small'},{gain=0.07},
			{loop=true})
			local percent = math.floor(meta:get_float('fuel_time') /
			meta:get_float('fuel_totaltime') * 100)
			meta:set_string('infotext','Campfire active: '..percent..'%')
			minetest.swap_node(pos, {name = 'more_fire:campfire'})
			meta:set_string('formspec',
			'size[8,6.75]'..
			default.gui_bg..
			default.gui_slots..
			'background[5,5;1,1;more_fire_campfire_active.png;true]'..
			'list[current_name;fuel;1,1.5;1,1;]'..
			'list[current_player;main;0,2.75;8,1;]'..
			'list[current_player;main;0,4;8,3;8]')
			return
			end
			local fuel = nil
			local fuellist = inv:get_list('fuel')
			if fuellist then
				fuel = minetest.get_craft_result({method = 'fuel', width = 1, items = fuellist})
			end
			if fuel.time <= 0 then
			local node = minetest.get_node(pos)
				if node.name == 'more_fire:campfire' then
					meta:set_string('infotext','Put more wood on the fire!')
					minetest.swap_node(pos, {name = 'more_fire:embers'})
					local timer = minetest.get_node_timer(pos)
					meta:set_string('formspec', more_fire.embers_formspec)
					timer:start(180)
				end
			return
		end
		meta:set_string('fuel_totaltime', fuel.time)
		meta:set_string('fuel_time', 0)
		local stack = inv:get_stack('fuel', 1)
		stack:take_item()
		inv:set_stack('fuel', 1, stack)
end,
})

minetest.register_abm({  -- Controls the contained fires.
	nodenames = {'more_fire:embers_contained', 'more_fire:campfire_contained'},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.env:get_meta(pos)
		for i, name in ipairs({
		'fuel_totaltime',
		'fuel_time',
		}) do
		if meta:get_string(name) == '' then
			meta:set_float(name, 0.0)
			end
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local was_active = false
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			was_active = true
			meta:set_float('fuel_time', meta:get_float('fuel_time') + 0.25)
			end
		if meta:get_float('fuel_time') < meta:get_float('fuel_totaltime') then
			minetest.sound_play({name='fire_small'},{gain=0.07},
			{loop=true})
			local percent = math.floor(meta:get_float('fuel_time') /
			meta:get_float('fuel_totaltime') * 100)
			meta:set_string('infotext','Campfire active: '..percent..'%')
			minetest.swap_node(pos, {name = 'more_fire:campfire_contained'})
			meta:set_string('formspec',
			'size[8,6.75]'..
			default.gui_bg..
			default.gui_slots..
			'background[5,5;1,1;more_fire_campfire_active.png;true]'..
			'list[current_name;fuel;1,1.5;1,1;]'..
			'list[current_player;main;0,2.75;8,1;]'..
			'list[current_player;main;0,4;8,3;8]')
			return
			end
			local fuel = nil
			local fuellist = inv:get_list('fuel')
			if fuellist then
				fuel = minetest.get_craft_result({method = 'fuel', width = 1, items = fuellist})
			end
			if fuel.time <= 0 then
				local node = minetest.get_node(pos)
				if node.name == 'more_fire:campfire_contained' then
					meta:set_string('infotext','Put more wood on the fire!')
					minetest.swap_node(pos, {name = 'more_fire:embers_contained'})
					meta:set_string('formspec', more_fire.embers_formspec)
					local timer = minetest.get_node_timer(pos)
					timer:start(190)
				end
			return
		end
		meta:set_string('fuel_totaltime', fuel.time)
		meta:set_string('fuel_time', 0)
		local stack = inv:get_stack('fuel', 1)
		stack:take_item()
		inv:set_stack('fuel', 1, stack)
end,
})

minetest.register_abm({ --smoke for embers
	nodenames = {'more_fire:embers', 'more_fire:embers_contained'},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' then
			smoke_particles(pos)
		end
	end
})

minetest.register_abm({ --embers for fire
	nodenames = {'more_fire:campfire', 'more_fire:campfire_contained'},
	interval = 1,
	chance = 2,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' then
			ember_particles(pos)
		end
	end
})

minetest.register_abm({ --lava
	nodenames = {'default:lava_source', 'default:lava_flowing'},
	interval = 4,
	chance = 15,
	action = function(pos, node)
		if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' then
			lava_particles(pos)
		end
	end
})
