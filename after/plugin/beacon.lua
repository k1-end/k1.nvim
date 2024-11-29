require('beacon').setup({
    min_jump = 2, --- integer what is considered a jump. Number of lines
    cursor_events = { 'CursorMoved', 'WinScrolled' }, -- table<string> what events trigger check for cursor moves
    speed = 1,
})
