-- Rex configuration.
--
-- The cmd shortcuts below come from the Ghostty config, where they typed
-- tmux prefix sequences; here they call Rex directly. Keys that Rex already
-- binds the same way by default are not repeated:
--   cmd+t new tab · cmd+w close pane · cmd+1..9 go to tab · cmd+k sessions
--   shift+cmd+w close window

local terminal = "com.superlogical.terminal"
local shell = "com.superlogical.terminal.shell"

---------------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------------

-- The directory of the focused pane's foreground program, if known.
local function focused_cwd(ctx)
  if ctx.block_id == nil then return nil end
  local p = rex.block.call(terminal, "process", { block_id = ctx.block_id })
  if p == nil then return nil end
  return (p.foreground and p.foreground.cwd) or (p.child and p.child.cwd)
end

local function shell_block(command, cwd)
  local options = { command = command }
  if cwd ~= nil then options.cwd = cwd end
  return rex.layout.block{ flavor = shell, options = options }
end

-- Opens `command` in a floating pane over the current window. It closes
-- when the command exits.
local function open_popup(command, cwd)
  local layer, err = rex.session.new_layer{
    bounds = { 0.075, 0.15, 0.85, 0.7 },
    focus  = true,
    layout = shell_block(command, cwd),
  }
  if err ~= nil then error(err, 0) end
  return { layer_id = layer.layer_id }
end

---------------------------------------------------------------------------
-- Actions
---------------------------------------------------------------------------

-- Runs a program in a popup, in the focused pane's directory.
rex.action{
  name  = "popup",
  title = "Run in Popup",
  args  = { command = "array" },
  run   = function(ctx, args)
    return open_popup(args.command, focused_cwd(ctx))
  end,
}

-- Runs a program in a new tab, in the focused pane's directory.
rex.action{
  name  = "tab",
  title = "Run in New Tab",
  args  = { command = "array" },
  run   = function(ctx, args)
    local w, err = rex.session.new_window{ layout = shell_block(args.command, focused_cwd(ctx)) }
    if err ~= nil then error(err, 0) end
    return { window_id = w.window_id }
  end,
}

-- Types text into the focused pane, escape sequences included.
rex.action{
  name  = "type",
  title = "Type Text",
  args  = { text = "string" },
  run   = function(ctx, args)
    if ctx.block_id == nil then error("no focused pane", 0) end
    local _, err = rex.block.call(terminal, "write", { block_id = ctx.block_id, data = args.text })
    if err ~= nil then error(err, 0) end
  end,
}

-- Pick a session or project directory (bin/rex-sessionizer).
rex.action{
  name  = "sessionizer",
  title = "Sessionizer",
  description = "Pick a session or project directory in a floating pane.",
  run   = function(ctx, args)
    local script = os.getenv("HOME") .. "/personal/dotfiles/bin/rex-sessionizer"
    if ctx.client_id == nil then return open_popup({ script }) end
    return open_popup({ "env", "REX_CLIENT=" .. ctx.client_id, script })
  end,
}

---------------------------------------------------------------------------
-- Key bindings
---------------------------------------------------------------------------

-- Config, sessions
rex.bind("shift+cmd+r", "client.config.reload")
rex.bind("ctrl+w", "sessionizer")
rex.bind("cmd+l", "session.previous")

-- Panes
rex.bind("cmd+e", "pane.split", { direction = "right" })
rex.bind("shift+cmd+e", "pane.split", { direction = "down" })
rex.bind("cmd+z", "pane.zoom")

-- Tools
rex.bind("cmd+g", "popup", { command = { "lazygit" } })
rex.bind("cmd+d", "popup", { command = { "lazydocker" } })
rex.bind("cmd+p", "popup", { command = { "btop" } })
rex.bind("shift+cmd+a", "tab", { command = { "claude" } })
