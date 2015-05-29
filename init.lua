-- A couple variables used throughout.
percent = 100
-- GUI related stuff
default.gui_bg = 'bgcolor[#080808BB;true]'
default.gui_bg_img = 'background[5,5;1,1;gui_formbg.png;true]'
default.gui_slots = 'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'

more_fire = {}

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

--configpath = minetest.get_mod_directory() ..'/config.txt'
--dofile(configpath)
dofile(minetest.get_modpath('more_fire')..'/config.txt')
dofile(minetest.get_modpath('more_fire')..'/functions.lua')
dofile(minetest.get_modpath('more_fire')..'/abms.lua')
dofile(minetest.get_modpath('more_fire')..'/nodes.lua')
dofile(minetest.get_modpath('more_fire')..'/craftitems.lua')
dofile(minetest.get_modpath('more_fire')..'/crafts.lua')
dofile(minetest.get_modpath('more_fire')..'/tools.lua')

