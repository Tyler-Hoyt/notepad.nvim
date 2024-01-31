local popup = require("plenary.popup")

function create_default_popup()
    local win_id = popup.create({ "menu item 1", "menu item 2", "menu item 3" }, {})
    print(win_id)
end

function Test ()
   print("Hello World");
end
