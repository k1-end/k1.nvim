return {
    'goolord/alpha-nvim',
    config = function()
        require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
        local dashboard = require 'alpha.themes.dashboard'
        dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
            dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
        }
        dashboard.section.header.val = {
            [[                              ]],
            [[            .-"""-.           ]],
            [[           '       \          ]],
            [[          |,.  ,-.  |         ]],
            [[          |()L( ()| |         ]],
            [[          |,'  `".| |         ]],
            [[          |.___.',| `         ]],
            [[         .j `--"' `  `.       ]],
            [[        / '        '   \      ]],
            [[       / /          `   `.    ]],
            [[      / /            `    .   ]],
            [[     / /              l   |   ]],
            [[    . ,               |   |   ]],
            [[    ,"`.             .|   |   ]],
            [[ _.'   ``.          | `..-'l  ]],
            [[|       `.`,        |      `. ]],
            [[|         `.    __.j         )]],
            [[|__        |--""___|      ,-' ]],
            [[   `"--...,+""""   `._,.-'    ]],
            [[                              ]],
            [[                              ]],
            [[                              ]],
            [[                              ]],
            [[                              ]],
        }
    end
}
