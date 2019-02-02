--Smoke Bomb_[rev001]
--base code is from throwing enhanced and potions mods

   local MOD_NAME = minetest.get_current_modname()
   local MOD_PATH = minetest.get_modpath(MOD_NAME)
   local Vec3 = dofile(MOD_PATH..'/lib/Vec3_1-0.lua')

minetest.register_craftitem('more_fire:smokebomb', {
		description = 'Smoke Bomb',
		inventory_image = 'more_fire_smokebomb.png',
on_place = function(itemstack, user, pointed_thing)
 itemstack:take_item()
  		minetest.sound_play('more_fire_shatter', {gain = 1.0})
  		--Shattered glass Particles
  		minetest.add_particlespawner({
			amount = 40,
			time = 0.1,
			minpos = pointed_thing.above,
			maxpos = pointed_thing.above,
			minvel = {x=2, y=0.2, z=2},
			maxvel = {x=-2, y=0.5, z=-2},
			minacc = {x=0, y=-6, z=0},
			maxacc = {x=0, y=-10, z=0},
			minexptime = 0.5,
			maxexptime = 2,
			minsize = 0.2,
			maxsize = 5,
			collisiondetection = true,
			texture = 'more_fire_shatter.png'})
  		 --smoke particles
  		 minetest.add_particlespawner({
			amount = 400,
			time = 0.1,
			minpos = pointed_thing.above,
			maxpos = pointed_thing.above,
			minvel = {x=2, y=0.2, z=2},
			maxvel = {x=-2, y=0.5, z=-2},
			minacc = {x=0, y=-6, z=0},
			maxacc = {x=0, y=-10, z=0},
			minexptime = 5,
			maxexptime = 2,
			minsize = 5,
			maxsize = 20,
			collisiondetection = true,
			texture = 'more_fire_smoke.png'})
  		--more smoke particles
		minetest.add_particlespawner({
			amount = 600,
			time = 1,
			minpos = pointed_thing.above,
			maxpos = pointed_thing.above,
			minvel = {x=10, y= 3, z=10},
			maxvel = {x=-10, y= 3, z=-10},
			minacc = {x=2, y=2, z=2},
			maxacc = {x=-2, y=1, z=-2},
			minexptime = 2,
			maxexptime = 3,
			minsize = 2,
			maxsize = 20,
			collisiondetection = true,
			texture = 'more_fire_smoke.png'})
		--even more smoke particles
  		minetest.add_particlespawner({
			amount = 400,
			time = 1,
			minpos = pointed_thing.above,
			maxpos = pointed_thing.above,
			minvel = {x=0.2, y=0.2, z=0.2},
			maxvel = {x=-0.2, y=0.5, z=-0.2},
			minacc = {x=10, y= 2, z=10},
			maxacc = {x=-10, y= 1, z=-10},
			minexptime = 2,
			maxexptime = 3,
			minsize = 20,
			maxsize = 2,
			collisiondetection = true,
			texture = 'more_fire_smoke.png'})
				local dir = Vec3(user:get_look_dir()) *20
				minetest.add_particle(
				{x=user:getpos().x, y=user:getpos().y+1.5, z=user:getpos().z}, {x=dir.x, y=dir.y, z=dir.z}, {x=0, y=-10, z=0}, 0.2,
					6, false, 'more_fire_smokebomb.png')
			return itemstack
		end,
	})

	local function throw_smokebomb(item, player)
	local playerpos = player:getpos()
	local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.625,z=playerpos.z}, 'more_fire:smokebomb_entity')
	local dir = player:get_look_dir()
	obj:setvelocity({x=dir.x*30, y=dir.y*30, z=dir.z*30})
	obj:setacceleration({x=dir.x*-3, y=-dir.y^8*80-10, z=dir.z*-3})
		if not minetest.settings:get_bool('creative_mode') then
		item:take_item()
	end
	return item
end

	local radius = 5

local function add_effects(pos, radius)
	minetest.add_particlespawner({
		amount = 200,
		time = 0.1,
		minpos = vector.subtract(pos, radius / 3),
		maxpos = vector.add(pos, radius / 3),
		minvel = {x=2, y=0.2, z=2},
		maxvel = {x=-2, y=-0.5, z=-2},
		minacc = {x=1, y=-6, z=1},
		maxacc = {x=1, y=-10, z=1},
		minexptime = 1,
		maxexptime = 5,
		minsize = 10,
		maxsize = 20,
		texture = 'more_fire_smoke.png',})
	minetest.add_particlespawner({
		amount = 100,
		time = 2,
		minpos = vector.subtract(pos, radius / 2),
		maxpos = vector.add(pos, radius / 2),
		minvel = {x=0.2, y=0.2, z=0.2},
		maxvel = {x=-0.2, y=0.5, z=-0.2},
		minacc = {x=10, y= 2, z=10},
		maxacc = {x=-10, y= 1, z=-10},
		minexptime =1,
		maxexptime = 3,
		minsize = 5,
		maxsize = 15,
		texture = 'more_fire_smoke.png',})
end

local function plume(pos)
	minetest.set_node(pos, {name='more_fire:plume'})
	minetest.get_node_timer(pos):start(3.0)
	add_effects(pos, radius)
end

local MORE_FIRE_SMOKEBOMB_ENTITY = {
	timer=0,
	collisionbox = {0,0,0,0,0,0},
	physical = false,
	textures = {'more_fire_smokebomb.png'},
	lastpos={},
}

MORE_FIRE_SMOKEBOMB_ENTITY.on_step = function(self, dtime)
	self.timer = self.timer + dtime
	local pos = self.object:getpos()
	local node = minetest.get_node(pos)
minetest.add_particlespawner({
		amount = 10,
		time = 0.5,
		minpos = pos,
		maxpos = pos,
		minvel = {x=-0, y=0, z=-0.5},
		maxvel = {x=0,  y=0,  z=-0.75},
		minacc = vector.new(),
		maxacc = vector.new(),
		minexptime = 0.5,
		maxexptime = 1,
		minsize = 0.25,
		maxsize = 0.5,
		texture = 'more_fire_smoke.png',})
	minetest.add_particlespawner({
		amount = 10,
		time = 0.25,
		minpos = pos,
		maxpos = pos,
		minvel = {x=-0, y=0, z=-0.5},
		maxvel = {x=0,  y=0,  z=-0.75},
		minacc = {x=0,  y=0,  z=-0.75},
		maxacc = {x=-0, y=0, z=-0.5},
		minexptime = 0.25,
		maxexptime = 0.5,
		minsize = 0.5,
		maxsize = 0.75,
		texture = 'more_fire_smoke.png',})
	if self.timer>0.2 then
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= 'more_fire:smokebomb_entity' and obj:get_luaentity().name ~= '__builtin:item' then
					if self.node ~= '' then
					 minetest.sound_play('more_fire_shatter', {gain = 1.0})
					local damage = 1
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
				end
			end
		end
	end
	if self.lastpos.x~=nil then
		if node.name ~= 'air' then
			self.object:remove()
			plume(self.lastpos)
		end
	end
	self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end
end

minetest.register_entity('more_fire:smokebomb_entity', MORE_FIRE_SMOKEBOMB_ENTITY)

minetest.override_item('more_fire:smokebomb', {on_use = throw_smokebomb})

minetest.register_node('more_fire:plume', {
drawtype = 'plantlike',
description = 'Smoke Plume',
	tiles = {{
		name='more_fire_smoke_animated.png',
		animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = 'more_fire_smoke.png',
	light_source = 8,
	groups = {dig_immediate=3, not_in_creative_inventory =1, not_in_craft_guide=1},
		drop = '',
	walkable = false,
	buildable_to = true,
		on_timer = function(pos, elapsed)
		minetest.remove_node(pos)
	end,
	damage_per_second = 1,
})

minetest.register_abm({
	nodenames={'more_fire:plume'},
	neighbors={'air'},
	interval = 1,
	chance = 1,
		action = function(pos, node)
	     if
                minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' and
                minetest.get_node({x=pos.x, y=pos.y+2.0, z=pos.z}).name == 'air'
             then
		minetest.add_particlespawner({
			amount = 400,
			time = 3,
			minpos = pos,
			maxpos = pos,
			minvel = {x=2, y=-0.2, z=2},
			maxvel = {x=-2, y=-0.5, z=-2},
			minacc = {x=0, y=-6, z=0},
			maxacc = {x=0, y=-10, z=0},
			minexptime = 2,
			maxexptime = 6,
			minsize = 0.05,
			maxsize = 0.5,
			collisiondetection =false,
			texture = 'more_fire_smoke.png'})
		minetest.add_particlespawner({
			amount = 50,
			time = 2,
			minpos = pos,
			maxpos = pos,
			minvel = {x=-2, y=0.5, z=-2},
			maxvel = {x=2, y=0.5, z=2},
			minacc = {x=0, y=0.04, z=0},
			maxacc = {x=0, y=0.01, z=0},
			minexptime = 1,
			maxexptime = 3,
			minsize = 3,
			maxsize = 5,
			collisiondetection = false,
			texture = 'more_fire_smoke.png'})
		minetest.add_particlespawner({
			amount = 400,
			time = 2,
			minpos = vector.subtract(pos, radius / 2),
			maxpos = vector.add(pos, radius / 2),
			minvel = {x=0.2, y=2, z=0.2},
			maxvel = {x=-0.2, y=2, z=-0.2},
			minacc = {x=10, y= 2, z=10},
			maxacc = {x=-10, y= 1, z=-10},
			minexptime =1,
			maxexptime = 3,
			minsize = 5,
			maxsize = 15,
			texture = 'more_fire_smoke.png',})
	     end
	end
})

	--crafting recipes
		minetest.register_craft( {
output = 'more_fire:smoke_bomb',
recipe = {
{'more_fire:flintstone'},
{'more_fire:charcoal'},
{'vessels:glass_bottle'},
}
})
