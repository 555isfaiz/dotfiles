lua << END
require('which-key').setup {
    win = {
	    border = "none",
		-- margin = { 1, 1, 1, 1 }
	    },
    triggers = {
       { "<auto>", mode = "nixsotc" },
       { "f", mode = { "n", "v" } },
    },
}
require('which-key').add({
    {
        "<space>?",
        function()
            require("which-key").show({ global = true })
        end,
        desc = "Which-key: Buffer Local Keymaps",
    },
})
END
