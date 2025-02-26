.PHONY: up down restart logs

up:
	docker compose up --detach

down:
	docker compose down

restart: down up

logs:
	docker compose logs -f
