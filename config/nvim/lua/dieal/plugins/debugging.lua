return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("nvim-dap-virtual-text").setup {}

      if os.getenv("VIRTUAL_ENV") ~= nil then
        local venvPath = os.getenv("VIRTUAL_ENV") .. "/bin/python"
        require("dap-python").setup()
      end

      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "[D]ebug Toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "[D]ebug [T]erminate" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "[D]ebug [R]estart" })
      vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "[D]ebug [S]tep [I]nto" })
      vim.keymap.set("n", "<leader>dsv", dap.step_over, { desc = "[D]ebug [S]tep O[v]er" })
      vim.keymap.set("n", "<leader>dso", dap.step_out, { desc = "[D]ebug [S]tep [O]ut" })
      vim.keymap.set("n", "<leader>dsb", dap.step_back, { desc = "[D]ebug [S]tep [B]ack" })

      -- Eval var under cursor
      vim.keymap.set("n", "<space>d?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  }
}
