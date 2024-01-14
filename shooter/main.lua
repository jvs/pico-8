function _init()
  globals.init()
  space.init()
  hero.init()
  bullets.init()
end

function _update60()
  space.update()
  globals.update()
  hero.update()
  bullets.update()

  camera(globals.camera_x, globals.camera_y)
end

function _draw()
  space.draw()
  hero.draw()
  bullets.draw()
end
