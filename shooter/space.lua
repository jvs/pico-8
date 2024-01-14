space = {}

space.num_stars = 200
space.buffer_x = 100
space.buffer_y = 10

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
    star.y += rnd(globals.screen_h + space.buffer_y)
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

    local adj_x = star.x - globals.camera_x
    local limit_x = globals.screen_w + space.buffer_x
    local adj_y = star.y - globals.camera_y
    local off_x = adj_x < -space.buffer_x or adj_x > limit_x
    local off_y = adj_y > globals.screen_h

    if (off_x or off_y) then
      space.stars[i] = space._create_star()
    end
  end
end

space.adjust = function()
  for _, star in ipairs(space.stars) do
    star.x += globals.travel_x
    star.y += globals.travel_y
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

  local total_w = globals.screen_w + space.buffer_x * 2

  return {
    x = rnd(total_w) - space.buffer_x + globals.camera_x,
    y = -space.buffer_y + globals.camera_y,
    speed = speed,
    color = color,
  }
end
