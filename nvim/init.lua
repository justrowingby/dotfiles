local vim = vim
local opt = vim.opt

opt.expandtab = true
opt.wrap = false

opt.list = true
opt.listchars = {
    tab = "»-",
    multispace = "·",
    leadmultispace = "▏ ",
    nbsp = "␣",
    trail = "▒",
    precedes = "<",
    extends = ">",
}

opt.undofile = true
opt.ignorecase = true
opt.smartcase = true

-- aggressively write swap files for minimal data loss in case of crash
opt.updatetime = 300
