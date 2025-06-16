.PHONY: fmt listener api worker

build:
	go build -o bin/listener cmd/listener/main.go
	go build -o bin/api cmd/api/main.go
	go build -o bin/worker cmd/worker/main.go


fmt:
	go fmt ./...

listener:
	@set -a; source ./local/.env; set +a; air -c ./local/.air.listener.toml

api:
	@set -a; source ./local/.env; set +a; air -c ./local/.air.api.toml

worker:
	@set -a; source ./local/.env; set +a; air -c ./local/.air.worker.toml

docker-build:
	docker build -f build/Dockerfile -t $(if $(TAG),$(TAG),afterburner:latest) .

docker-run:
	docker run -it $(if $(TAG),$(TAG),afterburner:latest)

docker-compose:
	docker compose -f local/docker-compose.yaml up