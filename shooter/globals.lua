
globals = {}
globals.screen_w = 128
globals.screen_h = 128
globals.frame_counter = 0


globals.init = function()
  globals.reset()
end

globals.reset = function()
  globals.camera_x = 0
  globals.camera_y = 0
  globals.camera_dx = 0
  globals.camera_dy = 0
end

globals.update = function()
  globals.frame_counter += 1

  if (globals.frame_counter > 100) then
    globals.frame_counter = 1
  end
end
