.PHONY: dev clean ls

dev: ## Start the plugin in development mode
	./dev.sh --start

clean: ## Clean/remove installed plugin
	./dev.sh --clean

ls: ## List plugins directory
	./dev.sh --ls
