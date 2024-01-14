function _init()
  space.init()
end

function _update60()
  space.update()
  hero.update()
  camera(globals.camera_x, globals.camera_y)
end

function _draw()
  space.draw()
  hero.draw()
end
