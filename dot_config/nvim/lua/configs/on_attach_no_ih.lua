local on_attach = require("configs.on_attach")
local on_attach_no_ih = function(client, buffnr)
	on_attach(client, buffnr, false)
end
return on_attach_no_ih