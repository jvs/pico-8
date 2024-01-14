guns.basic_gun = function()
  local gun = {}

  gun.bullet_w = 1
  gun.bullet_h = 5
  gun.cool_down = 0

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
  end

  gun.fire = function()
    if (gun.cool_down == 0) then
      gun.cool_down = 10
      bullets.add_bullet(gun.make_bullet())
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

  return gun
end
