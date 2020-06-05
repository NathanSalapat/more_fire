   --Molotov Cocktail_[rev002]
   --base code is from throwing enhanced and potions mods

local MOD_NAME = minetest.get_current_modname()
local MOD_PATH = minetest.get_modpath(MOD_NAME)
local Vec3 = dofile(MOD_PATH..'/lib/Vec3_1-0.lua')

minetest.register_craftitem('more_fire:molotov_cocktail', {
   description = 'Molotov Cocktail',
   inventory_image = 'more_fire_molotov_cocktail.png',
   on_place = function(itemstack, user, pointed_thing)
      itemstack:take_item()
      minetest.sound_play('more_fire_shatter', {gain = 1.0})
      n = minetest.get_node(pointed_thing)
      if pointed_thing.type == 'node' then
         minetest.add_node(pointed_thing.above, {name='more_fire:napalm'})
         minetest.sound_play('more_fire_ignite', {pos,pos})
      end
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
      minexptim = 0.5,
      maxexptime = 2,
      minsize = 0.2,
      maxsize = 5,
      collisiondetection = true,
      texture = 'more_fire_shatter.png'})
      --fire ember particles
      minetest.add_particlespawner({
      amount = 100,
      time = 0.1,
      minpos = pointed_thing.above,
      maxpos = pointed_thing.above,
      minvel = {x=-2, y=0.5, z=-2},
      maxvel = {x=2, y=0.5, z=2},
      minacc = {x=0, y=-10, z=0},
      maxacc = {x=0, y=-6, z=0},
      minexptime = 2,
      maxexptime = 3,
      minsize = 0.25,
      maxsize = 0.5,
      collisiondetection = true,
      texture = 'more_fire_spark.png'})
      local dir = Vec3(user:get_look_dir()) *20
      minetest.add_particle(
            {x=user:getpos().x, y=user:getpos().y+1.5, z=user:getpos().z}, {x=dir.x, y=dir.y, z=dir.z}, {x=0, y=-10, z=0}, 0.2,
               6, false, 'more_fire_molotov_cocktail.png')
         return itemstack
   end,
})

local function throw_cocktail(item, player)
   local playerpos = player:getpos()
   local obj = minetest.add_entity({x=playerpos.x,y=playerpos.y+1.625,z=playerpos.z}, 'more_fire:molotov_entity')
   local dir = player:get_look_dir()
   obj:setvelocity({x=dir.x*30, y=dir.y*30, z=dir.z*30})
   obj:setacceleration({x=dir.x*-3, y=-dir.y^8*80-10, z=dir.z*-3})
   if not minetest.settings:get_bool('creative_mode') then
      item:take_item()
   end
   return item
end

local radius = 5.0

local function add_effects(pos, radius)
   minetest.add_particlespawner({
      amount = 10,
      time = 0.2,
      minpos = vector.subtract(pos, radius / 2),
      maxpos = vector.add(pos, radius / 2),
      minvel = {x=-2, y=-2, z=-2},
      maxvel = {x=2,  y=-4,  z=2},
      minacc = {x=0, y=-4, z=0},
      --~ maxacc = {x=-20, y=-50, z=-50},
      minexptime = 1,
      maxexptime = 1.5,
      minsize = 1,
      maxsize = 2,
      texture = 'more_fire_spark.png',
   })
      minetest.add_particlespawner({
      amount = 10,
      time = 0.2,
      minpos = vector.subtract(pos, radius / 2),
      maxpos = vector.add(pos, radius / 2),
      minvel = {x=-1.25, y=-1.25, z=-1.25},
      maxvel = {x=0.5, y=-4, z=0.5},
      minacc = {x=1.25,  y=-1.25,  z=1.25},
      --~ maxacc = {x=-20, y=-50, z=-50},
      minexptime =1,
      maxexptime = 1.5,
      minsize = 1,
      maxsize = 2,
      texture = 'more_fire_spark.png',
   })
end

local function napalm(pos)
   minetest.sound_play('more_fire_ignite', {pos=pos, gain=1})
   minetest.set_node(pos, {name='more_fire:napalm'})
   minetest.get_node_timer(pos):start(5.0)
   add_effects(pos, radius)
end

local MORE_FIRE_MOLOTOV_ENTITY = {
   timer=0,
   collisionbox = {0,0,0,0,0,0},
   physical = false,
   textures = {'more_fire_molotov_cocktail.png'},
   lastpos={},
}

MORE_FIRE_MOLOTOV_ENTITY.on_step = function(self, dtime)
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
      texture = 'more_fire_smoke.png',
   })
   minetest.add_particlespawner({
      amount = 100,
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
      texture = 'more_fire_spark.png',
   })
   if self.timer>0.2 then
      local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1)
      for k, obj in pairs(objs) do
         if obj:get_luaentity() ~= nil then
            if obj:get_luaentity().name ~= 'more_fire:molotov_entity' and obj:get_luaentity().name ~= '__builtin:item' then
               if self.node ~= '' then
                minetest.sound_play('more_fire_shatter', {gain = 1.0})
                  for dx=-3,3 do
                     for dy=-3,3 do
                        for dz=-3,3 do
                           local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                           local n = minetest.get_node(pos).name
                           if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 20 then
                           minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                              minetest.set_node(p, {name='more_fire:napalm'})
                           else
                        --minetest.remove_node(p)
                        minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                        minetest.set_node(p, {name='fire:basic_flame'})
                           end
                        end
                     end
                  end
               end
               self.object:remove()
            end
         else
            if self.node ~= '' then
                  minetest.sound_play('more_fire_shatter', {gain = 1.0})
               for dx=-2,2 do
                  for dy=-2,2 do
                     for dz=-2,2 do
                        local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                        local n = minetest.get_node(pos).name
                        if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 20 then
                        minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                           minetest.set_node(p, {name='more_fire:napalm'})
                        else
                        --minetest.remove_node(p)
                        minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                        minetest.set_node(p, {name='fire:basic_flame'})
                        end
                     end
                  end
               end
            end
            self.object:remove()
         end
      end
   end

   if self.lastpos.x~=nil then
      if node.name ~= 'air' then
         if self.node ~= '' then
         minetest.sound_play('more_fire_shatter', {gain = 1.0})
            for dx=-1,1 do
               for dy=-1,1 do
                  for dz=-1,1 do
                     local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                     local n = minetest.get_node(pos).name
                     if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) <= 20 then
                        minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                        minetest.set_node(p, {name='more_fire:napalm'})
                     else
                        minetest.sound_play('more_fire_ignite', {pos = self.lastpos})
                        minetest.set_node(p, {name='fire:basic_flame'})
                     end
                  end
               end
            end
         end
         self.object:remove()
         napalm(self.lastpos)
      end
   end
   self.lastpos={x=pos.x, y=pos.y, z=pos.z}
end

minetest.register_entity('more_fire:molotov_entity', MORE_FIRE_MOLOTOV_ENTITY)

minetest.override_item('more_fire:molotov_cocktail', {on_use = throw_cocktail})

minetest.register_node('more_fire:napalm', {
   drawtype = 'firelike',
   tiles = {{
      name='fire_basic_flame_animated.png',
      animation={type='vertical_frames', aspect_w=16, aspect_h=16, length=1},
   }},
   inventory_image = 'fire_basic_flame.png',
   light_source = 14,
   groups = {igniter=1,dig_immediate=3, not_in_creative_inventory =1, not_in_craft_guide=1},
   drop = '',
   walkable = false,
   buildable_to = true,
   damage_per_second = 4,
})

minetest.register_abm({
   nodenames={'more_fire:napalm'},
   neighbors={'air'},
   interval = 1,
   chance = 1,
   action = function(pos,node,active_object_count,active_object_count_wider)
      minetest.add_particlespawner({
         amount = 200,
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
         collisiondetection = false,
         texture = 'more_fire_spark.png'})
      minetest.add_particlespawner({
         amount = 20,
         time = 2,
         minpos = pos,
         maxpos = pos,
         minvel = {x=-2, y=2, z=-2},
         maxvel = {x=1, y=3, z=1},
         minacc = {x=0, y=6, z=0},
         maxacc = {x=0, y=2, z=0},
         minexptime = 1,
         maxexptime = 3,
         minsize = 3,
         maxsize = 5,
         collisiondetection = false,
         texture = 'more_fire_smoke.png'})
      minetest.add_particlespawner({
         amount = 10,
         time = 4,
         minpos = pos,
         maxpos = pos,
         minvel = {x=0, y= 3, z=0},
         maxvel = {x=0, y=5, z=0},
         minacc = {x=0.1, y=0.5, z=-0.1},
         maxacc = {x=-0.2, y=2, z=0.2},
         minexptime = 1,
         maxexptime = 3,
         minsize = 1,
         maxsize = 3,
         collisiondetection = false,
         texture = 'more_fire_smoke.png'})
      local r = 0-- Radius for destroying
      for x = pos.x-r, pos.x+r, 1 do
         for y = pos.y-r, pos.y+r, 1 do
            for z = pos.z-r, pos.z+r, 1 do
               local cpos = {x=x,y=y,z=z}
               if minetest.get_node(cpos).name == 'more_fire:napalm' then
             minetest.set_node(cpos,{name='fire:basic_flame'})
               end
               if math.random(0,1) == 1
               or minetest.get_node(cpos).name == 'more_fire:napalm'
               then
                  minetest.remove_node(cpos)
               end
            end
         end
      end
   end,
})

minetest.register_abm({
   nodenames={'fire:basic_flame'},
   neighbors={'air'},
   interval = 1,
   chance = 2,
      action = function(pos, node)
      if minetest.get_node({x=pos.x, y=pos.y+1.0, z=pos.z}).name == 'air' and
         minetest.get_node({x=pos.x, y=pos.y+2.0, z=pos.z}).name == 'air' then
            minetest.add_particlespawner({
               amount = 30,
               time = 2,
               minpos = pos,
               maxpos = pos,
               minvel = {x=-2, y=2, z=-2},
               maxvel = {x=1, y=3, z=1},
               minacc = {x=0, y=6, z=0},
               maxacc = {x=0, y=2, z=0},
               minexptime = 1,
               maxexptime = 3,
               minsize = 10,
               maxsize = 20,
               collisiondetection = false,
               texture = 'more_fire_smoke.png'})
            minetest.add_particlespawner({
               amount = 15,
               time = 4,
               minpos = pos,
               maxpos = pos,
               minvel = {x=0, y= 3, z=0},
               maxvel = {x=0, y=5, z=0},
               minacc = {x=0.1, y=0.5, z=-0.1},
               maxacc = {x=-0.2, y=2, z=0.2},
               minexptime = 1,
               maxexptime = 3,
               minsize = 5,
               maxsize = 10,
               collisiondetection = false,
               texture ='more_fire_smoke.png'})
            end
         end
})

   --crafting recipes
minetest.register_craft( {
   output = 'more_fire:molotov_cocktail',
   recipe = {
      {'farming:cotton'},
      {'more_fire:oil'},
      {'vessels:glass_bottle'},
   }
})

-- fuel recipes
minetest.register_craft({
   type = 'fuel',
   recipe = 'more_fire:molotov_cocktail',
   burntime = 5,
})
