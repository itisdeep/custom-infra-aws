COMPOSE=docker compose \
	-f docker-compose.yml \
	-f DB/docker-compose.yml \
	-f backend/docker-compose.yml \
	-f frontend/docker-compose.yml

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

ps:
	$(COMPOSE) ps

logs:
	@if [ -z "$(SERVICE)" ]; then \
		echo "Usage: make logs SERVICE=<service_name>"; \
		echo "Example: make logs SERVICE=api"; \
		exit 1; \
	fi
	$(COMPOSE) logs -f $(SERVICE)
