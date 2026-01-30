return {
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        opts = {
            -- add any opts here
            -- for example
            -- provider = "ollama",
            provider = "openai",
            providers = {
                ollama = {
                    model = "deepseek-r1:14b",
                },
                openai = {
                    endpoint = "https://api.openai.com/v1",
                    model = "gpt-4.1",             -- your desired model (or use gpt-4o, etc.)
                    extra_request_body = {
                        temperature = 1,
                        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
                        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
                    }
                },
            },
            behaviour = {
                auto_suggestions = false, -- Experimental stage
                auto_set_highlight_group = true,
                auto_set_keymaps = true,
                auto_apply_diff_after_generation = false,
                support_paste_from_clipboard = false,
                minimize_diff = true,     -- Whether to remove unchanged lines when applying a code block
                enable_token_counting = true, -- Whether to enable token counting. Default to true.
                auto_add_current_file = true, -- Whether to automatically add the current file when opening a new chat. Default to true.
                auto_approve_tool_permissions = true, -- Default: auto-approve all tools (no prompts)
                -- Examples:
                -- auto_approve_tool_permissions = false,                -- Show permission prompts for all tools
                -- auto_approve_tool_permissions = {"bash", "str_replace"}, -- Auto-approve specific tools only
                ---@type "popup" | "inline_buttons"
                confirmation_ui_style = "inline_buttons",
                --- Whether to automatically open files and navigate to lines when ACP agent makes edits
                ---@type boolean
                acp_follow_agent_locations = true,
            },
            input = {
                provider = "snacks",
                provider_opts = {
                    -- Additional snacks.input options
                    title = "Avante Input",
                    icon = " ",
                },
            },
            selector = {
                --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
                provider = "snacks",
                -- Options override for custom providers
                provider_opts = {},
            }
        },
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = "make",
        -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            -- "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}
