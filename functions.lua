function default.get_hotbar_bg(x,y)
	local out = ''
	for i=0,7,1 do
		out = out ..'image['..x+i..','..y..';1,1;gui_hb_bg.png]'
	end
	return out
end

function more_fire.fire_formspec(item_percent)
	local formspec =
		'size[8,6.75]'..
		default.gui_slots..
		'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'..
		'background[8,6.75;0,0;more_fire_campfire_bg.png;true]'..
		'label[2,.75;< Add More Wood]'..
		'label[1.25,2; Cook Something >]'..
		'list[current_name;fuel;1,.5;1,1;]'..
		'list[current_name;src;4,1.75;1,1;]'..
		'image[5,1.75;1,1;gui_furnace_arrow_bg.png^[lowpart:'..
		(item_percent)..':gui_furnace_arrow_fg.png^[transformR270]'..
		'list[current_name;dst;6,1.75;2,1;]'..
		'list[current_player;main;0,2.75;8,1;]'..
		'list[current_player;main;0,4;8,3;8]'..
		default.get_hotbar_bg(0,2.75)
	return formspec
end

more_fire.embers_formspec =
'size[8,6.75]'..
default.gui_slots..
'listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]'..
'background[8,6.75;0,0;more_fire_campfire_bg.png;true]'..
'label[2,.75;< Add More Wood]'..
'label[1.25,2; Cook Something >]'..
'list[current_name;fuel;1,.5;1,1;]'..
'list[current_name;src;4,1.75;1,1;]'..
'image[5,1.75;1,1;gui_furnace_arrow_bg.png^[transformR270]'..
'list[current_name;dst;6,1.75;2,1;]'..
'list[current_player;main;0,2.75;8,1;]'..
'list[current_player;main;0,4;8,3;8]'..
default.get_hotbar_bg(0,2.75)

function smoke_particles(pos)
    minetest.add_particlespawner({
        amount = 1, -- how many particles do you want
        time = 2, -- spawner stops after this time (use 0 for infinite)
        minpos = {x=pos.x, y=pos.y, z=pos.z}, -- minimum offset
        maxpos = {x=pos.x, y=pos.y, z=pos.z}, -- maximum offset
        minvel = {x=-.1, y=0, z=-.1}, -- minimum velocity
        maxvel = {x=.1,  y=.4,  z=.1}, -- maximum velocity
        minacc = {x=-.05, y=.02, z=-.05}, -- minimum acceleration
        maxacc = {x=.1, y=.1, z=.1}, -- maximim acceleration
        minexptime = 3, -- minimum expiration time
        maxexptime = 6, -- maximum expiration time
        minsize = 3, -- minimum size (0.5 = half size)
        maxsize = 8, -- maximum size (1=full resolution)
        collisiondetection = false, -- do particles stop when they hit solid node
        texture = 'more_fire_smoke.png', -- image to use (e.g. 'bubble.png' )
        vertical = false, -- upright/vertical image for rain
--      playername = 'singleplayer', -- particles only appear for this player
    })
end

function ember_particles(pos)
	minetest.add_particlespawner({
        amount = 1,
        time = 2,
        minpos = {x=pos.x, y=pos.y, z=pos.z},
        maxpos = {x=pos.x, y=pos.y, z=pos.z},
        minvel = {x=-.15, y=.3, z=-.15},
        maxvel = {x=.1,  y=.6,  z=.1},
        minacc = {x=-.05, y=.02, z=-.05},
        maxacc = {x=.1, y=.3, z=.1},
        minexptime = 1,
        maxexptime = 3,
        minsize = 1,
        maxsize = 2,
        collisiondetection = false,
        texture = 'more_fire_embers.png',
        vertical = false,
--      playername = 'singleplayer',
    })
end

function lava_particles(pos)
	minetest.add_particlespawner({
        amount = 2,
        time = 1,
        minpos = {x=pos.x, y=pos.y-.5, z=pos.z},
        maxpos = {x=pos.x, y=pos.y, z=pos.z},
        minvel = {x=-.4, y=1, z=-.4},
        maxvel = {x=.4,  y=1.5,  z=.4},
        minacc = {x=-.4, y=1, z=-.4},
        maxacc = {x=.4, y=1.5, z=.4},
        minexptime = 1,
        maxexptime = 1.5,
        minsize = .6,
        maxsize = 2,
        collisiondetection = false,
        texture = 'more_fire_lava_blob.png',
        vertical = false,
--      playername = 'singleplayer',
    })
end
