bullets = {}
bullets.bullets = {}

bullets.init = function()
end

bullets.update = function()
  local next_bullets = {}
  for _, bullet in ipairs(bullets.bullets) do
    bullet.update()
    if (bullet.is_alive) then
      add(next_bullets, bullet)
    end
  end
  bullets.bullets = next_bullets
end

bullets.draw = function()
  for _, bullet in ipairs(bullets.bullets) do
    bullet.draw()
  end
end

bullets.add_bullet = function(bullet)
  add(bullets.bullets, bullet)
end
