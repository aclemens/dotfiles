return {
	"kdheepak/lazygit.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		vim.keymap.set("n", "<leader><leader>", ":LazyGit<CR>", { desc = "Open LazyGit" })
	end,
}
