local on_attach = require("configs.on_attach")
local on_attach_ih = function(client, buffnr)
	on_attach(client, buffnr, true)
end
return on_attach_ih
