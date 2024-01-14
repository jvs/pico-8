function _init()
  globals.init()
  space.init()
  hero.init()
end

function _update60()
  space.update()
  globals.update()
  hero.update()

  camera(globals.camera_x, globals.camera_y)
end

function _draw()
  space.draw()
  hero.draw()
end
