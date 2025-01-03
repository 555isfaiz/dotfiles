local mason_lspconfig = require "mason-lspconfig"

local home_dir = os.getenv('HOME')

local function get_server(name)
    local servers = mason_lspconfig.get_installed_servers()
    if vim.tbl_contains(servers, name) then
        return true, require("lspconfig")[name]
    end
    return false, nil
end

local is_file_exist = function(path)
    local f = io.open(path, 'r')
    return f ~= nil and io.close(f)
end

local fn = vim.fn

local get_lombok_javaagent = function()
    local lombok_dir = home_dir .. '/.m2/repository/org/projectlombok/lombok/'
    local lombok_versions = io.popen('ls -1 "' .. lombok_dir .. '" | sort -r')
    if lombok_versions ~= nil then
        local lb_i, lb_versions = 0, {}
        for lb_version in lombok_versions:lines() do
            lb_i = lb_i + 1
            lb_versions[lb_i] = lb_version
        end
        lombok_versions:close()
        if next(lb_versions) ~= nil then
            local lombok_jar = fn.expand(string.format('%s%s/lombok-%s.jar', lombok_dir, lb_versions[1], lb_versions[1]))
            if is_file_exist(lombok_jar) then
                return string.format('--jvm-arg=-javaagent:%s', lombok_jar)
            end
        end
    end
    return ''
end

local ok, jdtls = get_server "jdtls"

if not ok then
    vim.notify("mason-lspconfig: jdtls not found, please install it first", vim.log.levels.ERROR)
    return
end

local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')
local project_setting = fn.getcwd() .. "/.jdtls"

local settingsTable = {}
local file = io.open(project_setting, "r") -- Open the file in read mode

if file then
    for line in file:lines() do
        local key, value = line:match("^(%S+)%s*=%s*(%S+)$")
        if key and value then
            settingsTable[key] = value
        end
    end
    file:close()
end

local format_url = settingsTable["format_setting"] or "https://gist.githubusercontent.com/ikws4/7880fdcb4e3bf4a38999a628d287b1ab/raw/9005c451ed1ff629679d6100e22d63acc805e170/jdtls-formatter-style.xml"

local workspace_dir = home_dir .. "/.cache/jdtls/workspace/" .. project_name

local get_jdp_javaagent = function()
    local jdp_dir = home_dir .. '/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/'
    local jdp_versions = io.popen('ls -1 "' .. jdp_dir .. '" | sort -r')
    if jdp_versions ~= nil then
        local lb_i, lb_versions = 0, {}
        for lb_version in jdp_versions:lines() do
            lb_i = lb_i + 1
            lb_versions[lb_i] = lb_version
        end
        jdp_versions:close()
        if next(lb_versions) ~= nil then
            local jdp_jar = fn.expand(string.format('%s/%s', jdp_dir, lb_versions[1]))
            if is_file_exist(jdp_jar) then
                return jdp_jar
            end
        end
    end
    return ''
end

local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true
                }
            }
        }
    }

local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local bundles = {
    -- vim.fn.glob(get_jdp_javaagent(), 1),
    vim.fn.glob(vim.fn.stdpath('data')..'/mason/packages/java-test/extension/server/*.jar', true ),
    vim.fn.glob(vim.fn.stdpath('data')..'/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
}
-- vim.list_extend(bundles, vim.split(vim.fn.glob(home_dir .. "/.config/nvim/ftplugin/vscode-java-test/server/*.jar", 1), "\n"))

local config = {
    -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
    capabilities = capabilities,
    on_attach = function()
        require("jdtls.setup").add_commands()
        require('jdtls.dap').setup_dap_main_class_configs()
        -- require 'lspsaga'.init_lsp_saga()
    end,
    cmd = {
        'jdtls',
        '-config',
        home_dir .. '/.cache/jdtls/config',
        '-data',
        workspace_dir,
        get_lombok_javaagent(),
    },
    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),
    settings = {
        java = {
            format = {
                comments = {
                    enabled = false,
                },
                settings = {
                    url = format_url,
                },
            },
            completion = {
                importOrder = {
                    "java",
                    "javax",
                    "jakarta",
                    "org",
                    "com"
                }
            },
            autobuild = {
                enabled = false, -- Disable automatic builds
            },
            eclipse = {
                downloadSource = true,
            },
        },
    },
    init_options = {
        bundles = bundles,
        extendedClientCapabilities = extendedClientCapabilities;
    },
}

require("which-key").add({
    {'<space>tc', function() require'jdtls'.compile() require'jdtls'.test_class() end, desc = "Jdtls: debug current test class"},
    {'<space>tm', function() require'jdtls'.compile() require'jdtls'.test_nearest_method() end, desc = "Jdtls: debug current test method"},
})

require("jdtls").start_or_attach(config)
