hero = {}

hero.w = 5
hero.h = 6
hero.ideal_x = flr((globals.screen_w - hero.w) / 2)
hero.ideal_y = globals.screen_h - hero.h - 20

hero.x = hero.ideal_x
hero.y = hero.ideal_y

hero.main_gun = guns.basic_gun()

hero.fire_palettes = {
  red = {
    ears = 2,
    head = 8,
    body = 9,
    tail = 10,
    flicker = 0.5,
  },
  green = {
    ears = 3,
    head = 11,
    body = 11,
    tail = 10,
    flicker = 0.6,
  },
}

hero.fire_palette = hero.fire_palettes.red


hero.init = function()
end

hero.update = function()
  if (hero.main_gun) then
    hero.main_gun.update()
  end

  local dx = 0
  local dy = 0

  if (btn(0) and not btn(1)) then
    dx = -1
  elseif (btn(1) and not btn(0)) then
    dx = 1
  end

  if (btn(2) and not btn(3)) then
    dy = -1
  elseif (btn(3) and not btn(2)) then
    dy = 1
  end

  globals.camera_dx = dx
  globals.camera_dy = dy

  if (dx == 0) then
    local ideal_x = hero.ideal_x + globals.camera_x
    if (hero.x ~= ideal_x) then
      globals.camera_x += (hero.x > ideal_x) and 0.5 or -0.5
    end
  else
    hero.x += dx * 2
    globals.camera_x += dx
  end

  if (dy == 0) then
    local ideal_y = hero.ideal_y + globals.camera_y
    if (hero.y ~= ideal_y) then
      globals.camera_y += (hero.y > ideal_y) and 0.5 or -0.5
    end
  else
    hero.y += dy * 2
    globals.camera_y += dy
  end

  if (btn(4) and hero.main_gun) then
    hero.main_gun.fire()
  end

  if (btn(5)) then
    -- Just for now:
    if (hero.fire_palette == hero.fire_palettes.red) then
      hero.fire_palette = hero.fire_palettes.green
    else
      hero.fire_palette = hero.fire_palettes.red
    end
  end
end

hero.adjust = function()
  hero.x += globals.travel_x
  hero.y += globals.travel_y
end

hero.draw = function()
  hero.draw_fire_trail(hero.fire_palette)
  spr(1, hero.x, hero.y)
end

hero.draw_fire_trail = function(palette)
  local start_x = hero.x
  local start_y = hero.y + hero.h

  local function bend()
    if (rnd(1) >= 0.3) then
      start_x -= globals.camera_dx
    end
  end

  local function maybe_set(x, y, color)
    if (rnd(1) <= palette.flicker) then
      pset(x, y, color)
    end
  end

  if (globals.camera_dy > 0) then
    start_y -= 1
  end

  for i = 1,hero.w do
    local head_color = (i == 1 or i == hero.w) and palette.ears or palette.head
    maybe_set(start_x + i, start_y + 1, head_color)
  end

  bend()
  for i = 2,(hero.w - 1) do
    maybe_set(start_x + i, start_y + 2, palette.body)
  end

  if (globals.camera_dy < 0) then
    bend()
    for i = 2,(hero.w - 1) do
      maybe_set(start_x + i, start_y + 3, palette.body)
    end
    bend()
    maybe_set(start_x + 3, start_y + 4, palette.tail)
    start_y += 2
  end

  start_x -= globals.camera_dx
  maybe_set(start_x + 3, start_y + 3, palette.tail)
end
