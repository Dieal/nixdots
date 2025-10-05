glide.keymaps.set("normal", "<leader>s", "tab_new about:settings")
glide.keymaps.set("normal", "<leader>r", "config_reload")
glide.keymaps.set("normal", "<leader>c", "clear")
glide.keymaps.set("normal", "<Backspace>", "back")
glide.keymaps.set("normal", "<C-Backspace>", "forward")

// Tabs
glide.keymaps.set(["normal", "insert"], "<C-j>", "tab_prev")
glide.keymaps.set(["normal", "insert"], "<C-k>", "tab_next")

glide.keymaps.set(["normal", "insert"], "<C-h>", () => {
    glide.excmds.execute("tab_prev");
    glide.excmds.execute("tab_prev");
})

glide.keymaps.set(["normal", "insert"], "<C-l>", () => {
    glide.excmds.execute("tab_next");
    glide.excmds.execute("tab_next");
})
