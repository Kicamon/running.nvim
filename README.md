# running.nvim
- Lightwight and fast
- Running with float window
- Support multiple languages

### Screenshot
![demo](https://ice.frostsky.com/2024/08/29/cff6ed61a14ecd42f6a04e2ee206f531.gif)

### Install
**lazy.nvim**

```lua
{
    "Kicamon/running.nvim",
    lazy = true,
    cmd = "Run",
    config = function()
        require('running').setup()
    end
}
```

**vim-plug**

```vim
Plug "Kicamon/running.nvim", {['on'] = 'Run' }}
lua require('running').setup()
```

### command
| open         | description                             |
|--------------|-----------------------------------------|
| `Run`        | Open fLoat window at right ahd running  |
| `Run center` | Open fLoat window at center ahd running |

### Configuration
defualt config
```lua
require('running').setup({
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
})
```

### Set Language command
```lua
require('running').setup({
    commands = {
        ['c'] = {
            command = {
                'gcc "$filename" -o "$runfile"',
                './"$runfile"',
            },
        },
        ['html'] = {
            command = 'live-server',
            modus = 'job', -- run a shell command
        },
        ['markdown'] = {
            command = 'MarkdownPreview',
            modus = 'cmd', -- execute a vim command
        }
    }
})
```

---

### License MIT
