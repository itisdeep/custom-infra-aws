build:
	docker build -t todo-app-backend:latest ./backend
	docker build -t todo-app-frontend:latest ./frontend

deploy:
	docker stack deploy -c todo-app-stack.yml todo-app

logs-backend:
	docker service logs todo-app_backend

logs-frontend:
	docker service logs todo-app_frontend

network:
	docker network create --driver overlay public-net
	docker network create --driver overlay backend-net
	docker network create --driver overlay db-net
