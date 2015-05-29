function default.get_hotbar_bg(x,y)
	local out = ''
	for i=0,7,1 do
		out = out ..'image['..x+i..','..y..';1,1;gui_hb_bg.png]'
	end
	return out
end

function more_fire.campfire(pos, percent, item_percent)
	local formspec =
	'size[8,6.75]'..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	'background[5,5;1,1;more_fire_campfire_active.png;true]'..
	'list[current_name;fuel;1,1.5;1,1;]'..
	'list[current_player;main;0,2.75;8,1;]'..
	'list[current_player;main;0,4;8,3;8]'..
	default.get_hotbar_bg(0,2.75)
	return formspec
end

function more_fire.get_campfire_formspec(pos, percent)
	local meta = minetest.get_meta(pos)local inv = meta:get_inventory()
	local fuellist = inv:get_list('fuel')
	if fuellist then
		end
	return more_fire.campfire(pos, percent, item_percent)
end

function burn(pointed_thing) --kindling doesn't always start from the first spark
	local ignite_chance = math.random(5)
	if ignite_chance == 1
		and string.find(minetest.get_node(pointed_thing.under).name, 'more_fire:kindling_contained')
		then
			minetest.set_node(pointed_thing.under, {name = 'more_fire:embers_contained'})
	elseif ignite_chance == 1
		and string.find(minetest.get_node(pointed_thing.under).name, 'more_fire:kindling')
		then
			minetest.set_node(pointed_thing.under, {name = 'more_fire:embers'})
	else --Do nothing
	end
end

function smoke_particles(pos)
    minetest.add_particlespawner({
        amount = 1, -- how many particles do you want
        time = 0, -- spawner stops after this time (use 0 for infinite)
        minpos = {x=pos.x, y=pos.y, z=pos.z}, -- minimum offset
        maxpos = {x=pos.x, y=pos.y, z=pos.z}, -- maximum offset
        minvel = {x=-.1, y=0, z=-.1}, -- minimum velocity
        maxvel = {x=.1,  y=.4,  z=.1}, -- maximum velocity
        minacc = {x=-.05, y=.02, z=-.05}, -- minimum acceleration
        maxacc = {x=.1, y=.1, z=.1}, -- maximim acceleration
        minexptime = 3, -- minimum expiration time
        maxexptime = 8, -- maximum expiration time
        minsize = 3, -- minimum size (0.5 = half size)
        maxsize = 8, -- maximum size (1=full resolution)
        collisiondetection = false, -- do particles stop when they hit solid node
        texture = 'more_fire_smoke.png', -- image to use (e.g. "bubble.png" )
        vertical = false, -- upright/vertical image for rain
--        playername = "singleplayer", -- particles only appear for this player
    })
end
