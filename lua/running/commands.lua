local running_commands = {}

local commands = {
  ['c'] = {
    command = {
      'gcc "$filename" -o "$runfile"',
      './"$runfile"',
    },
  },
  ['cpp'] = {
    command = {
      'g++ "$filename" -o "$runfile"',
      './"$runfile"',
    },
  },
  ['make'] = {
    command = {
      'cd $workspace',
      'make test',
    },
    modus = 'center',
  },
  ['rust'] = {
    command = {
      'rustc "$filename"',
      './"$runfile"',
    },
  },
  ['python'] = {
    command = 'python3 "$filename"',
  },
  ['lua'] = {
    command = 'luajit "$filename"',
  },
  ['sh'] = {
    command = 'bash "$filename"',
  },
  ['javascript'] = {
    command = 'node "$filename"',
  },
  ['go'] = {
    command = 'go run "$filename"',
  },
  ['html'] = {
    command = 'live-server',
    modus = 'job',
  },
}

function running_commands.get_commands()
  return commands
end

function running_commands.commands_list()
  return vim.tbl_keys(commands)
end

return running_commands
