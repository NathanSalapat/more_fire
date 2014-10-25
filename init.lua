-- A couple variables used throughout.
LIGHT_MAX = 14
percent = 100
-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"
more_fire = {}

-- functions
function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

function more_fire.campfire_active(pos, percent, item_percent)
    local formspec = 
	"size[8,6.75]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;fuel;2,1.5;4,1;]"..
	"list[current_player;main;0,2.75;8,1;]"..
	"list[current_player;main;0,4;8,3;8]"..
	default.get_hotbar_bg(0,2.75)
    return formspec
  end
  
function more_fire.get_campfire_active_formspec(pos, percent)
	local meta = minetest.get_meta(pos)local inv = meta:get_inventory()
	local fuellist = inv:get_list("fuel")
	if fuellist then
		
	end
	local item_percent = 0
	if cooked then
		item_percent = meta:get_float("src_time")/cooked.time
	end
       
        return more_fire.campfire_active(pos, percent, item_percent)
end

  
-- formspecs
more_fire.campfire_inactive_formspec =
	"size[8,6.75]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;fuel;2,1.5;4,1;]"..
	"list[current_player;main;0,2.75;8,1;]"..
	"list[current_player;main;0,4;8,3;8]"..
	default.get_hotbar_bg(0,2.75)

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

minetest.register_node(':default:torch', {
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
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-1/11, -1/2, -1/11, 1/11, 1/3, 1/11},
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
	buildable_to = false,
	damage_per_second = 1,
	drop = 'more_fire:charcoal',
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=2,hot=2,attached_node=1,dig_immediate=3,igniter=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', more_fire.campfire_inactive_formspec)
		meta:set_string('infotext', 'Campfire')
		local inv = meta:get_inventory()
		inv:set_size('fuel', 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty('fuel') then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == 'fuel' then
			if inv:is_empty('fuel') then
				meta:set_string("infotext","Campfire is out of wood.")
				return stack:get_count()
			else
				return 0
			end
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method="fuel",width=4,items={stack}}).time ~= 0 then
				if inv:is_empty("fuel") then
					meta:set_string("infotext","Campfire is out of wood.")
				end
				return count
			else
				return 0
			end
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
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
	light_source = 20,
	is_ground_content = true,
	groups = {cracky=2,hot=2,attached_node=1,dig_immediate=3},
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

