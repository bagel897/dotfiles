local M = {}
local dap = require "dap"

function M.reload_continue()
  package.loaded["dap_setup"] = nil
  require("dap_setup")
  dap.continue()
end

require("dap_setup")
return M
