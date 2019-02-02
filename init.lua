-- A couple variables used throughout.
percent = 100
-- GUI related stuff
default.gui_bg = 'bgcolor[#080808BB;true]'
default.gui_bg_img = 'background[5,5;1,1;gui_formbg.png;true]'
default.gui_slots = 'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'

more_fire = {}

dofile(minetest.get_modpath('more_fire')..'/functions.lua')
dofile(minetest.get_modpath('more_fire')..'/abms.lua')
dofile(minetest.get_modpath('more_fire')..'/nodes.lua')
dofile(minetest.get_modpath('more_fire')..'/craftitems.lua')
dofile(minetest.get_modpath('more_fire')..'/crafts.lua')
dofile(minetest.get_modpath('more_fire')..'/tools.lua')
if minetest.settings:get_bool('more_fire.pyromania') then
	dofile(minetest.get_modpath('more_fire')..'/molotov.lua')
	dofile(minetest.get_modpath('more_fire')..'/smokebomb.lua')
end
