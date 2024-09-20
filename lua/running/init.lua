local win = require('running.window')
local api = vim.api
local infos = {}

local config = {
  commands = require('running.commands'),
  win = {
    defualt = {
      width = -0.25,
      height = 0.9,
      row = 't',
      col = 'r',
    },
    center = {
      width = 0.8,
      height = 0.8,
      row = 'c',
      col = 'c',
    },
  },
}

local function get_commands()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')
  local runfile = vim.fn.expand('%<')

  local opt = config.commands[filetype]

  if not opt then
    return opt
  end

  if type(opt.command) == 'table' then
    local tmp = ''
    ---@diagnostic disable-next-line: param-type-mismatch
    for i, val in ipairs(opt.command) do
      tmp = tmp .. (i ~= 1 and ' && ' or '') .. val
    end
    opt.command = tmp
  end

  ---@diagnostic disable-next-line: param-type-mismatch
  opt.command = opt.command:gsub('$filename', filename):gsub('$runfile', runfile)

  return opt
end

local function running_window(opt, center)
  local float_opt = {
    relative = 'editor',
    title = ' Code Running ',
  }

  float_opt =
    vim.tbl_extend('force', float_opt, (center and config.win.center or config.win.defualt) or {})

  infos.bufnr, infos.winid = win:new_float(float_opt, true, true):wininfo()

  api.nvim_create_autocmd('WinClosed', {
    buffer = infos.bufnr,
    callback = function()
      if infos.winid and api.nvim_win_is_valid(infos.winid) then
        api.nvim_win_close(infos.winid, true)
        api.nvim_buf_delete(infos.bufnr, { force = true })
        infos.winid = nil
      end
    end,
  })

  vim.cmd.term(opt)
end

local function running(center)
  vim.cmd('w')

  local workpath = vim.fn.getcwd()

  vim.cmd('silent! lcd %:p:h')

  local opt = get_commands()
  if opt then
    if opt.modus == 'job' then
      vim.fn.jobstart(opt.command)
    elseif opt.modus == 'cmd' then
      vim.cmd(opt.command)
    else
      running_window(opt.command, center)
    end
  else
    vim.notify(
      string.format('%s running command undefined\n', vim.bo.filetype),
      vim.log.levels.WARN
    )
  end

  vim.cmd('silent! lcd ' .. workpath)
end

local function setup(opts)
  config = vim.tbl_extend('force', config, opts or {})

  api.nvim_create_user_command('Run', function(args)
    running(args.args == 'center')
  end, {
    nargs = '?',
    complete = function()
      return { 'center' }
    end,
  })
end

return { setup = setup }
