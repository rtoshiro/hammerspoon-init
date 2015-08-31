# Hammerspoon 

I'm not going to explain what is **Hammerspoon** or teach you Lua.

I'll just explain how to use my "init.lua" file, if you don't want spending time on it.

# Download

The init.lua is [here](https://gist.github.com/rtoshiro/6ca47e18cd1c20364b0d). Please share with me if you improve it :)

# Shortcuts

	cmd + alt + right key
	cmd + alt + left key
	cmd + alt + up key
	cmd + alt + down key
	ctrl + cmd + alt + right key
	ctrl + cmd + alt + left key
	ctrl + cmd + alt + up key
	ctrl + cmd + alt + down key
	cmd + alt + c
	ctrl + cmd + alt + c
	cmd + alt + f
	ctrl + cmd + alt + f

	ctrl + cmd + alt + r (reloads init.lua file)
	ctrl + cmd + alt + 2 (apply all layouts)
	ctrl + cmd + alt + 3 (apply only one layout (focused one))

# Layouts:

You can configure the variable "layouts" (line 31) according your monitor configuration.

### The sintax is:

```
  {
    name = "App name" ou { "App name", "App name" }
    func = function(index, win)
      COMMANDS
    end
  },
```

### Example

```
  {
    name = {"Firefox", "iTunes"},
    func = function(index, win)
      win:moveToScreen(hs.screen.get("Color LCD"))
      win:maximize()
    end
  },
```

If you call "ctrl + cmd + alt + 3", it will apply all layouts you defined.

If you call "ctrl + cmd + alt + 2", the layout will be applied only on the focused application.

