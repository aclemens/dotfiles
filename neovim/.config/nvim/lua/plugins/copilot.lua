return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    config = function()
      local chat = require("CopilotChat")

      chat.setup({
        vim.keymap.set("n", "<leader>co", ":CopilotChatOpen<CR>", { desc = "Open Copilot Chat" }),
        vim.keymap.set("n", "<leader>cc", ":CopilotChatClose<CR>", { desc = "Close Copilot Chat" }),
        vim.keymap.set("n", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain the code (last selection)" }),
        vim.keymap.set("v", "<leader>ce", ":CopilotChatExplain<CR>", { desc = "Explain the selected code" }),
        vim.keymap.set("n", "<leader>cd", ":CopilotChatDocs<CR>", { desc = "Create documentation (current line)" }),
        vim.keymap.set("v", "<leader>cd", ":CopilotChatDocs<CR>", { desc = "Create documentation for selected code" }),
      })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
