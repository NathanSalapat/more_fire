minetest.register_abm({  -- Controls non-contained fire
	nodenames = {'more_fire:embers','more_fire:campfire'},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local fuel_time = meta:get_float("fuel_time") or 0
		local src_time = meta:get_float("src_time") or 0
		local fuel_totaltime = meta:get_float("fuel_totaltime") or 0
		local inv = meta:get_inventory()
		local srclist = inv:get_list("src")
		local cooked = nil
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		local was_active = false
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 0.25)
			meta:set_float("src_time", meta:get_float("src_time") + 0.25)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				if inv:room_for_item("dst",cooked.item) then
					inv:add_item("dst", cooked.item)
					local srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			minetest.sound_play({name="campfire_small"},{pos=pos}, {max_hear_distance = 1},{loop=true},{gain=0.009})
			local percent = math.floor(meta:get_float("fuel_time") /
			meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Campfire active: "..percent.."%")
			minetest.swap_node(pos, {name = 'more_fire:campfire'})
			return
		end
		
		local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		local cookable = true
		if cooked.time == 0 then
			cookable = false
		end
		
		local item_state = ''
		local item_percent = 0
		if cookable then
			item_percent =  math.floor(src_time / cooked.time * 100)
			item_state = item_percent .. "%"
		end
		
		meta:set_string("formspec", more_fire.fire_formspec(item_percent))

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end
		
		if fuel.time <= 0 then
			meta:set_string("infotext","The campfire is out.")
			minetest.swap_node(pos, {name = 'more_fire:embers'})
			meta:set_string("formspec", more_fire.fire_formspec(item_percent))
			return
		end
		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})

minetest.register_abm({  -- Controls the contained fires.
	nodenames = {'more_fire:embers_contained', 'more_fire:campfire_contained'},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local meta = minetest.get_meta(pos)
		local fuel_time = meta:get_float("fuel_time") or 0
		local src_time = meta:get_float("src_time") or 0
		local fuel_totaltime = meta:get_float("fuel_totaltime") or 0
		local inv = meta:get_inventory()
		local srclist = inv:get_list("src")
		local cooked = nil
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		local was_active = false
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 0.25)
			meta:set_float("src_time", meta:get_float("src_time") + 0.25)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				if inv:room_for_item("dst",cooked.item) then
					inv:add_item("dst", cooked.item)
					local srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end

		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			minetest.sound_play({name="campfire_small"},{pos=pos}, {max_hear_distance = 1},{loop=true},{gain=0.009})
			local percent = math.floor(meta:get_float("fuel_time") /
			meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Campfire active: "..percent.."%")
			minetest.swap_node(pos, {name = 'more_fire:campfire_contained'})
			return
		end
		
		local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		local cookable = true
		if cooked.time == 0 then
			cookable = false
		end
		
		local item_state = ''
		local item_percent = 0
		if cookable then
			item_percent =  math.floor(src_time / cooked.time * 100)
			item_state = item_percent .. "%"
		end
		
		meta:set_string("formspec", more_fire.fire_formspec(item_percent))

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end
		
		if fuel.time <= 0 then
			meta:set_string("infotext","The campfire is out.")
			minetest.swap_node(pos, {name = 'more_fire:embers_contained'})
			meta:set_string("formspec", more_fire.embers_formspec)
			return
		end
		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
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
