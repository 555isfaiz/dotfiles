set autoindent
set relativenumber
set smartindent
set number
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set clipboard+=unnamedplus
set pumheight=10
set noshowmode
set splitbelow
set splitright
set signcolumn=yes
set updatetime=100
set laststatus=3
set spell spelllang=en_us

nnoremap <silent> <Tab> :>1<CR>
vnoremap <silent> <Tab> :'<,'>1><CR>gv

map <silent> <C-m> :WindowsMaximize<CR>

map <silent> S vsu
vmap <silent> S su

nnoremap <silent> <M-k> :m .-2<CR>==
nnoremap <silent> <M-j> :m .+1<CR>==
vnoremap <silent> <M-k> :m '<-2<CR>gv=gv
vnoremap <silent> <M-j> :m '>+1<CR>gv=gv

tnoremap <Esc><Esc> <C-\><Cn>

nnoremap <silent>    <A-h> <C-O>
nnoremap <silent>    <A-l> <C-I>
map <silent>     ' <C-W>
" map <silent>     8 <C-W>+
" map <silent>     2 <C-W>-
" map <silent>     4 <C-W>>
" map <silent>     6 <C-W><

map <silent>     <C-l> $
map <silent>     <C-h> ^

" map <silent>     <F4> <C-W>s<Cmd>:terminal<CR><Cmd>:horizontal resize 15<CR>

lua << END
vim.g.mapleader = " "
vim.o.signcolumn = 'yes:3'
vim.lsp.diagnostic.enable = true
local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }                                                    
for type, icon in pairs(signs) do                                                                                        
    local hl = "DiagnosticSign" .. type                                                                                    
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })                                                       
end   
END
