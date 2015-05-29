-- A couple variables used throughout.
percent = 100
-- GUI related stuff
default.gui_bg = 'bgcolor[#080808BB;true]'
default.gui_bg_img = 'background[5,5;1,1;gui_formbg.png;true]'
default.gui_slots = 'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'

more_fire = {}

--[[local function start_embers(pos)
		local this_spawner_meta = minetest.get_meta(pos)
		id = minetest.add_particlespawner({
			amount = 1, time = 0,
			minpos = { x = pos.x - 0.4, y = pos.y - 0.4, z = pos.z - 0.4 },
			maxpos = { x = pos.x + 0.4, y = pos.y - 0.4, z = pos.z + 0.4 },
			minvel = { x = 0, y = 0, z = 0 },
			maxvel = { x = 0, y = .3, z = 0 },
			minacc = { x = 0, y = .1, z = 0 },
			maxacc = { x = 0, y = .25, z = 0 },
			minexptime = 3,	maxexptime = 5,
			size = 8,
			collisiondetection = false,
			vertical = false,
			texture = 'more_fire_embers.png',
			})
		this_spawner_meta:set_int(id)
		end
			
smoke_particles = {
			amount = 1, time = 0,
			minpos = { x = pos.x - 0.4, y = pos.y - 0.4, z = pos.z - 0.4 },
			maxpos = { x = pos.x + 0.4, y = pos.y - 0.4, z = pos.z + 0.4 },
			minvel = { x = 0, y = 0, z = 0 },
			maxvel = { x = 0, y = .2, z = 0 },
			minacc = { x = 0, y = .05, z = 0 },
			maxacc = { x = 0, y = .1, z = 0 },
			minexptime = 3,	maxexptime = 5,
			size = 2,
			collisiondetection = false,
			vertical = false,
			texture = 'more_fire_smoke.png',}--]]

-- formspecs
more_fire.embers_formspec =
'size[8,6.75]'..
default.gui_bg..
default.gui_bg_img..
default.gui_slots..
'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'..
'background[5,5;1,1;more_fire_campfire_inactive.png;true]'..
'list[current_name;fuel;1,1.5;1,1;]'..
'list[current_player;main;0,2.75;8,1;]'..
'list[current_player;main;0,4;8,3;8]'..
default.get_hotbar_bg(0,2.75)

dofile(minetest.get_modpath('more_fire')..'/config.txt')
dofile(minetest.get_modpath('more_fire')..'/functions.lua')
dofile(minetest.get_modpath('more_fire')..'/abms.lua')
dofile(minetest.get_modpath('more_fire')..'/nodes.lua')
dofile(minetest.get_modpath('more_fire')..'/craftitems.lua')
dofile(minetest.get_modpath('more_fire')..'/crafts.lua')
dofile(minetest.get_modpath('more_fire')..'/tools.lua')

