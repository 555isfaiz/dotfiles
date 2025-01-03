-- Function to close all windows with a specific filetype
function close_windows_with_filetype(filetype)
    local windows = vim.api.nvim_list_wins()
    for win in windows do
        local buf = vim.api.nvim_win_get_buf(win)
        print(buf)
        local buf_filetype = vim.api.nvim_buf_get_option(buf, "filetype")
        if buf_filetype == filetype then
            vim.api.nvim_win_close(win, false) -- Close the window
        end
    end
end
