lua << END
require('persistence').setup {
  dir = vim.fn.stdpath("state") .. "/sessions/", -- directory where session files are saved
  -- minimum number of file buffers that need to be open to save
  -- Set to 0 to always save
  need = 0,
  branch = true, -- use git branch to save session
}

require("which-key").add({
    {"<space>sl", function() require("persistence").load() end, desc = "Persistence: load session for current directory"},
    {"<space>ss", function() require("persistence").select() end, desc = "Persistence: select session"},
    {"<space>so", function() require("persistence").load({ last = true }) end, desc = "Persistence: load last session"},
    {"<space>sq", function() require("persistence").stop() end, desc = "Persistence: stop session (won't be saved on exit)"},
})
END
