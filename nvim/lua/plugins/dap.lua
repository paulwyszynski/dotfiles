if true then
  return {}
end
-- INFO: I'm using flutter-tools.nvim for this
--
-- return {
--   "mfussenegger/nvim-dap",
--   config = function()
--     local dap = require("dap")
--     dap.adapters.flutter = {
--       type = "executable",
--       command = "flutter", -- if you're using fvm, you'll need to provide the full path to flutter (flutter.bat for windows users), or you could prepend the fvm command
--       args = { "debug_adapter" }, -- windows users will need to set 'detached' to false
--       options = {
--         detached = false,
--       },
--     }
--     dap.configurations.dart = {
--       {
--         type = "flutter",
--         request = "launch",
--         name = "Launch flutter",
--         dartSdkPath = "/opt/homebrew/bin/dart", -- ensure this is correct
--         flutterSdkPath = "/opt/homebrew/bin/flutter", -- ensure this is correct
--       },
--     }
--   end,
-- }
