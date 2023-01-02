local M = {
	tsserver = {},
	astro = {},
	sumneko_lua = {},
	rust_analyzer = {},
	pyright = {},
	bashls = {},

	tailwindcss = {
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "classList", "ngClass" },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
				experimental = {
					classRegex = {
						"clsx\\('([^)]*)'\\)",
						{ "clsx\\(([^)]*)\\)", "'([^']*)'" },
					},
				},
			},
		},
	},
}

return M
