guns.basic_gun = function()
  local gun = {}

  gun.bullet_w = 1
  gun.bullet_h = 5
  gun.cool_down = 0
  gun.fire_frame = 0
  gun.is_firing = false
  gun.current_bullet = nil

  gun.bullet_palette = {
    head = 7,
    body = 11,
    tail = 3,
  }

  gun.update = function()
    gun.cool_down -= 1
    if (gun.cool_down < 0) then
      gun.cool_down = 0
    end
    if (gun.is_firing) then
      gun.fire_frame += 1
    end
  end

  gun.fire = function()
    if (gun.cool_down == 0) then
      gun.cool_down = 10
      gun.is_firing = true
      gun.fire_frame = 0

      local bullet = gun.make_bullet()
      gun.current_bullet = bullet
      bullets.add_bullet(bullet)
    end
  end

  gun.make_bullet = function()
    local bullet = {}
    bullet.x = hero.x + flr(hero.w / 2 - gun.bullet_w / 2) + 1
    bullet.y = hero.y + 1
    bullet.dx = globals.camera_dx / 2
    bullet.is_alive = true

    bullet.draw = function()
      local palette = gun.bullet_palette
      pset(bullet.x, bullet.y, palette.head)
      rectfill(
        bullet.x,
        bullet.y + 1,
        bullet.x + gun.bullet_w - 1,
        bullet.y + gun.bullet_h - 2,
        palette.body
      )
      pset(bullet.x, bullet.y + gun.bullet_h - 1, palette.tail)
    end

    bullet.update = function()
      if (bullet.y < globals.camera_y) then
        bullet.is_alive = false
      else
        bullet.y -= 2 - globals.camera_dy
      end
      bullet.x += bullet.dx
    end

    return bullet
  end

  gun.draw = function()
    if (gun.is_firing) then
      local center_x = hero.x + flr(hero.w / 2) + 1

      if (gun.fire_frame < 4) then
        gun.current_bullet.x = center_x
      end

      if (gun.fire_frame == 0) then
        rectfill(
          center_x - 1,
          hero.y - 2,
          center_x + 1,
          hero.y - 1,
          gun.bullet_palette.head
        )
      elseif (gun.fire_frame == 1) then
        rectfill(
          center_x - 1,
          hero.y - 3,
          center_x + 1,
          hero.y - 1,
          gun.bullet_palette.body
        )
      elseif (gun.fire_frame == 2) then
        rectfill(
          center_x - 3,
          hero.y - 4,
          center_x + 3,
          hero.y - 1,
          gun.bullet_palette.tail
        )
      elseif (gun.fire_frame == 3) then
        rectfill(
          center_x - 4,
          hero.y - 3,
          center_x + 4,
          hero.y - 1,
          gun.bullet_palette.tail
        )
      elseif (gun.fire_frame == 4) then
        rectfill(
          center_x - 6,
          hero.y - 1,
          center_x + 6,
          hero.y - 1,
          gun.bullet_palette.tail
        )
      else
        gun.is_firing = false
        gun.current_bullet = nil
      end
    end
  end

  return gun
end
