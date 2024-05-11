help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  install     to install all dependencies"
	@echo "  dev         to run the development server"

dev:
	@cd ./frontend/datum-pithos && bun run dev

install:
	@cd ./frontend/datum-pithos && bun install