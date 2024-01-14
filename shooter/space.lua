space = {}

space.num_stars = 700

space.x = -globals.screen_w
space.y = -globals.screen_h
space.w = globals.screen_w * 3
space.h = globals.screen_h * 3

space.palettes = {
  muted = {
    background = 1,
    star_colors = {
      blazing = {4, 15, 7, 9, 10},
      fast = 6,
      normal = 13,
      slow = 5,
    },
  },
}

space.palette = space.palettes.muted
space.stars = {}

space.init = function()
  for i = 1,space.num_stars do
    star = space._create_star()
    star.y = space.y + rnd(space.h)
    space.stars[i] = star
  end
end

space.update = function()
  local camera_dy = globals.camera_dy

  for i, star in ipairs(space.stars) do
    if (camera_dy > 0 and camera_dy > star.speed) then
      star.y += camera_dy
    else
      star.y += star.speed
    end

    if (star.y - space.y > space.h) then
      space.stars[i] = space._create_star()
    end
  end
end

space.draw = function()
  cls(space.palette.background)
  for _, star in ipairs(space.stars) do
    pset(star.x, star.y, star.color)
  end
end

space._create_star = function()
  local speed = rnd(2) + 0.35
  local colors = space.palette.star_colors

  if (speed > 2.15) then
    color = rnd(colors.blazing)
  elseif (speed > 1.85) then
    color = colors.fast
  elseif (speed > 1.35) then
    color = colors.normal
  else
    color = colors.slow
  end

  return {
    x=rnd(space.w) + space.x,
    y=space.y,
    speed=speed,
    color=color,
  }
end
