--------------------------------------------------------------------------------
-- rtoshiro - https://github.com/rtoshiro
-- You should see: http://www.hammerspoon.org/docs/index.html
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}
local main_monitor = "Color LCD"
local second_monitor = "DELL P2217H"

--------------------------------------------------------------------------------
-- CONFIGURATIONS
--------------------------------------------------------------------------------
hs.window.animationDuration = 0

--------------------------------------------------------------------------------
-- LAYOUTS
-- SINTAX:
--  {
--    name = "App name" ou { "App name", "App name" }
--    func = function(index, win)
--      COMMANDS
--    end
--  },
--
-- It searches for application "name" and call "func" for each window object
--------------------------------------------------------------------------------
local layouts = {
  {
    name = {"Airmail", "Mail", "Calendar", "iTunes", "Last.fm Scrobbler", "Messages", "Skype", "Dash", "Firefox", "Postman", "Franz"},
    func = function(index, win)
      win:moveToScreen(hs.screen.get(main_monitor))
      win:maximize()
    end
  },
  {
    name = {"TextWrangler"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
        hs.window.fullscreenAlmostCenter(win)
      else
        win:maximize()
      end
    end
  },
  {
    name = {"Cocoa Rest Client", "MacDown", "Yummy FTP Pro"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
        hs.window.fullscreenCenter(win)
      else
        win:maximize()
      end
    end
  },
  {
    name = {"Evernote", "JSON Accelerator", "Preview", "Slack"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
        hs.window.fullscreenCenter(win)
      else
        win:maximize()
      end
    end
  },
  {
    name = {"Xcode", "SourceTree", "Sequel Pro", "Android Studio"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
        hs.window.fullscreenWidth(win)
      else
        win:maximize()
      end
    end
  },
  {
    name = "Finder",
    func = function(index, win)

      if (index == 1) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        hs.window.upLeft(win)
      elseif (index == 2) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        hs.window.downLeft(win)
      elseif (index == 3) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        hs.window.downRight(win)
      elseif (index == 4) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        hs.window.upRight(win)
      elseif (index == 5) then
        win:moveToScreen(hs.screen.get(main_monitor))

        hs.window.upLeft(win)
      elseif (index == 6) then
        win:moveToScreen(hs.screen.get(main_monitor))

        hs.window.downLeft(win)
      elseif (index == 7) then
        win:moveToScreen(hs.screen.get(main_monitor))

        hs.window.downRight(win)
      elseif (index == 8) then
        win:moveToScreen(hs.screen.get(main_monitor))

        hs.window.upRight(win)
      else
        win:close()
      end
    end
  },
  {
    name = "iTerm2",
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
      end

      if (index == 1) then
        hs.window.upLeft(win)
      elseif (index == 2) then
        hs.window.upRight(win)
      elseif (index == 3) then
        hs.window.downLeft(win)
      elseif (index == 4) then
        hs.window.downRight(win)
      end
    end
  },
  {
    name = "iOS Simulator",
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
      end

      local screen = win:screen()
      local screen_frame = screen:frame()
      local frame = win:frame()
      frame.x = screen_frame.w / 2
      frame.y = screen_frame.y
      win:setFrame(frame)
    end
  },
  {
    name = {"player"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
      end
      
      local minFrame = hs.screen.minFrame(win:screen(), false)
      local screen = win:screen()
      local screen_frame = screen:frame()
      local frame = win:frame()
      if (index % 3 == 0) then
        frame.x = screen_frame.w - 200
        frame.y = (math.floor(index / 3) - 1) * (screen_frame.h / 2)
        frame.w = 260
        frame.h = screen_frame.h / 2
      end


      win:setFrame(frame)
    end
  },
  {
    name = {"_Android Studio"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
      end

      local minFrame = hs.screen.minFrame(win:screen(), false)
      local screen = win:screen()
      local screen_frame = screen:frame()
      local frame = win:frame()
      frame.x = win:screen():frame().x
      frame.y = minFrame.y
      frame.w = win:screen():frame().w - 260
      frame.h = minFrame.h
      win:setFrame(frame)
    end
  },
  {
    name = {"Atom", "Light Table"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then

        local allScreens = hs.screen.allScreens()
        for i, screen in ipairs(allScreens) do
          if screen:name() == second_monitor then
            win:moveToScreen(screen)
          end
        end

        local screen = win:screen()
        win:setFrame({
          x = screen:frame().x,
          y = hs.screen.minY(screen),
          w = hs.screen.minWidth(false) + hs.screen.minX(screen),
          h = hs.screen.minHeight(screen)
        })
      else
        win:maximize()
      end
    end
  },
}

local closeAll = {
  "iTunes",
  "Skype",
  "Messages",
  "XCode",
  "Android Studio",
  "Simulator",
  "Word",
  "Excel",
  "TextWrangler",
  "Cocoa Rest Client",
  "Last.fm",
  "Preview",
  "JSON Accelerator",
  "Yummy FTP Pro",
  "player",
  "FileMerge",
  "Fabric",
  "Color Picker",
  "Dash",
  "Genymotion"
}

local openAll = {
  "iTunes",
  "Skype",
  "Messages",
  "Last.fm",
  "Dash"
}

newWindowWatcher = {
  "Sequel Pro",
  "SourceTree",
}


function config()
  hs.hotkey.bind(cmd_alt, "right", function()
    local win = hs.window.focusedWindow()
    hs.window.right(win)
  end)

  hs.hotkey.bind(cmd_alt, "left", function()
    local win = hs.window.focusedWindow()
    hs.window.left(win)
  end)

  hs.hotkey.bind(cmd_alt, "up", function()
    local win = hs.window.focusedWindow()
    hs.window.up(win)
  end)

  hs.hotkey.bind(cmd_alt, "down", function()
    local win = hs.window.focusedWindow()
    hs.window.down(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "left", function()
    local win = hs.window.focusedWindow()
    hs.window.upLeft(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "down", function()
    local win = hs.window.focusedWindow()
    hs.window.downLeft(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "right", function()
    local win = hs.window.focusedWindow()
    hs.window.downRight(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "up", function()
    local win = hs.window.focusedWindow()
    hs.window.upRight(win)
  end)

  hs.hotkey.bind(cmd_alt, "c", function()
    local win = hs.window.focusedWindow()
    hs.window.fullscreenCenter(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "c", function()
    local win = hs.window.focusedWindow()
    hs.window.fullscreenAlmostCenter(win)
  end)

  hs.hotkey.bind(cmd_alt, "f", function()
    local win = hs.window.focusedWindow()
    win:maximize()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "f", function()
    local win = hs.window.focusedWindow()
    if (win) then
      hs.window.fullscreenWidth(win)
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "h", function()
    hs.hints.windowHints()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "1", function()
    local win = hs.window.focusedWindow()
    if (win) then
      win:moveToScreen(hs.screen.get(second_monitor))
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "2", function()
    local win = hs.window.focusedWindow()
    if (win) then
      win:moveToScreen(hs.screen.get(main_monitor))
      win:maximize()
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "R", function()
    hs.reload()
    hs.alert.show("Config loaded")
--
--local win = hs.window.focusedWindow()
--    local app = win:application()
--
--          hs.alert.show(app:title())
--          
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "P", function()
    hs.alert.show("Closing")
    for i,v in ipairs(closeAll) do
      local app = hs.application(v)
      if (app) then
        if (app.name) then
          hs.alert.show(app:name())
        end
        if (app.kill) then
        app:kill()
      end
      end
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "O", function()
    hs.alert.show("Openning")
    for i,v in ipairs(openAll) do
      hs.alert.show(v)
      hs.application.open(v)
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "3", function()
    applyLayouts(layouts)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "4", function()

    local focusedWindow = hs.window.focusedWindow()
    local app = focusedWindow:application()
    if (app) then
      applyLayout(layouts, app)
    end
  end)
end
--------------------------------------------------------------------------------
-- END CONFIGURATIONS
--------------------------------------------------------------------------------










--------------------------------------------------------------------------------
-- METHODS - BECAREFUL :)
--------------------------------------------------------------------------------
function applyLayout(layouts, app)
  if (app) then
    local appName = app:title()

    for i, layout in ipairs(layouts) do
      if (type(layout.name) == "table") then
        for i, layAppName in ipairs(layout.name) do
          if (layAppName == appName) then
            hs.alert.show(appName)
          
            local wins = app:allWindows()
            local counter = 1
            for j, win in ipairs(wins) do
              if (win:isVisible() and layout.func) then
                layout.func(counter, win)
                counter = counter + 1
              end
            end
          end
        end
      elseif (type(layout.name) == "string") then
        if (layout.name == appName) then
          local wins = app:allWindows()
          local counter = 1
          for j, win in ipairs(wins) do
            if (win:isVisible() and layout.func) then
              layout.func(counter, win)
              counter = counter + 1
            end
          end
        end
      end
    end
  end
end

function applyLayouts(layouts)
  for i, layout in ipairs(layouts) do
    if (type(layout.name) == "table") then
      for i, appName in ipairs(layout.name) do
--        local app = hs.appfinder.appFromName(appName)
        local app = hs.application.find(appName)
--      hs.alert.show(app:title())
        if (app) then
          local wins = app:allWindows()
          local counter = 1
          for j, win in ipairs(wins) do
            if (win:isVisible() and layout.func) then
              layout.func(counter, win)
              counter = counter + 1
            end
          end
        end
      end
    elseif (type(layout.name) == "string") then
      local app = hs.appfinder.appFromName(layout.name)
      if (app) then
        local wins = app:allWindows()
        local counter = 1
        for j, win in ipairs(wins) do
          if (win:isVisible() and layout.func) then
            layout.func(counter, win)
            counter = counter + 1
          end
        end
      end
    end
  end
end

function hs.screen.get(screen_name)
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    if screen:name() == screen_name then
      return screen
    end
  end
end

-- Returns the width of the smaller screen size
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minWidth(isFullscreen)
  local min_width = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_width = math.min(min_width, screen_frame.w)
  end
  return min_width
end

-- isFullscreen = false removes the toolbar
-- and dock sizes
-- Returns the height of the smaller screen size
function hs.screen.minHeight(isFullscreen)
  local min_height = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_height = math.min(min_height, screen_frame.h)
  end
  return min_height
end

-- If you are using more than one monitor, returns X
-- considering the reference screen minus smaller screen
-- = (MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.minX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + ((refScreen:frame().w - hs.screen.minWidth()) / 2)
  end
  return min_x
end

-- If you are using more than one monitor, returns Y
-- considering the focused screen minus smaller screen
-- = (MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2
-- If using only one monitor, returns the Y of focused screen
function hs.screen.minY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + ((refScreen:frame().h - hs.screen.minHeight()) / 2)
  end
  return min_y
end

-- If you are using more than one monitor, returns the
-- half of minX and 0
-- = ((MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.almostMinX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + (((refScreen:frame().w - hs.screen.minWidth()) / 2) - ((refScreen:frame().w - hs.screen.minWidth()) / 4))
  end
  return min_x
end

-- If you are using more than one monitor, returns the
-- half of minY and 0
-- = ((MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2) / 2
-- If using only one monitor, returns the Y of ref screen
function hs.screen.almostMinY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + (((refScreen:frame().h - hs.screen.minHeight()) / 2) - ((refScreen:frame().h - hs.screen.minHeight()) / 4))
  end
  return min_y
end

-- Returns the frame of the smaller available screen
-- considering the context of refScreen
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minFrame(refScreen, isFullscreen)
  local result = {
    x = hs.screen.minX(refScreen),
    y = hs.screen.minY(refScreen),
    w = hs.screen.minWidth(isFullscreen),
    h = hs.screen.minHeight(isFullscreen)
  }
  return result
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.x = minFrame.x + (minFrame.w/2)
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.y = minFrame.y + minFrame.h/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
-- Where the window's size is equal to
-- the smaller available screen size
function hs.window.fullscreenCenter(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame(minFrame)
end

-- +------------------+
-- |                  |
-- |  +------------+  +--> minY
-- |  |    HERE    |  |
-- |  +------------+  |
-- |                  |
-- +------------------+
function hs.window.fullscreenAlmostCenter(win)
  local offsetW = hs.screen.minX(win:screen()) - hs.screen.almostMinX(win:screen())
  win:setFrame({
    x = hs.screen.almostMinX(win:screen()),
    y = hs.screen.minY(win:screen()),
    w = hs.screen.minWidth(isFullscreen) + (2 * offsetW),
    h = hs.screen.minHeight(isFullscreen)
  })
end

-- It like fullscreen but with minY and minHeight values
-- +------------------+
-- |                  |
-- +------------------+--> minY
-- |       HERE       |
-- +------------------+--> minHeight
-- |                  |
-- +------------------+
function hs.window.fullscreenWidth(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = win:screen():frame().x,
    y = minFrame.y,
    w = win:screen():frame().w,
    h = minFrame.h
  })
end

windowWatcher = {}

function windowWatcherListener(element, event, watcher, userData) 
  local appName = userData.name
  local app = hs.application.find(appName)
  if (app) then
    applyLayout(layouts, app)
  end
end

function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == "iTerm") then
      appObject:selectMenuItem({"Window", "Bring All to Front"})
    elseif (appName == "Finder") then
      appObject:selectMenuItem({"Window", "Bring All to Front"})
    end
  end

  if (eventType == hs.application.watcher.launched) then
    os.execute("sleep " .. tonumber(1))
    applyLayout(layouts, appObject)
    
    for i, aname in ipairs(newWindowWatcher) do
      if (appName == aname) then      
        if (not windowWatcher[aname]) then
          hs.alert.show("Watching " .. appName)
          windowWatcher[aname] = appObject:newWatcher(windowWatcherListener, { name = appName })
          windowWatcher[aname]:start({hs.uielement.watcher.windowCreated})
        end
      end
    end
  end
  
  if (eventType == hs.application.watcher.terminated) then  
    for i, aname in ipairs(newWindowWatcher) do
      if (appName == aname) then      
        if (windowWatcher[aname]) then
          hs.alert.show("Stop watching " .. appName)
          windowWatcher[aname]:stop()
          windowWatcher[aname] = nil
        end
      end
    end
  end
end


config()
appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()


