-- tailscale: Tailscale's state on the workspace bar.
--
-- Data comes from the omniwm-tailscale-feed script, which runs
-- `omniwmctl shell set tailscale.state <state>` (plus tailscale.exit and
-- tailscale.backend). Until it has run once, the widget draws nothing.
-- First-pass look; the real UI comes later.

local look = require("../lib/look")

local STATES = {
    connected = { symbol = "network", text = "Tailscale" },
    ["exit-node"] = { symbol = "globe" }, -- text: exit node name
    disconnected = { symbol = "network.slash", text = "Off" },
    unavailable = { symbol = "exclamationmark.triangle", text = "Tailscale?" },
}

function render(ctx)
    local state = ctx.select("vars", "tailscale.state")
    local style = STATES[state]
    if not style then
        return ui.box{ w = 0, h = 0 }
    end

    local text = style.text
    local help = "Tailscale: connected"
    if state == "exit-node" then
        text = ctx.select("vars", "tailscale.exit") or "exit node"
        help = "Tailscale: connected through exit node " .. text
    elseif state == "disconnected" then
        help = "Tailscale: not connected (" .. (ctx.select("vars", "tailscale.backend") or "unknown") .. ")"
    elseif state == "unavailable" then
        help = "Tailscale: the CLI couldn't reach Tailscale (is the app running?)"
    end

    return look.bar(ctx, {
        symbol = style.symbol,
        help = help,
        ui.text{ text = text },
    })
end
