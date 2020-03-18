COMPOSE_FILES=-f ./consumers.yml -f ./kafka.yml -f dataload.yml

ifeq (pull,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  PULL_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(PULL_SERVICES):;@:)
endif
.PHONY: pull
pull:
	docker-compose $(COMPOSE_FILES) pull $(PULL_SERVICES)

ifeq (up,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  UP_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(UP_SERVICES):;@:)
endif
.PHONY: up
up:
	docker-compose $(COMPOSE_FILES) up -d $(UP_SERVICES)

ifeq (down,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  DOWN_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(DOWN_SERVICES):;@:)
endif
.PHONY: down
down:
	docker-compose $(COMPOSE_FILES) down

ifeq (logs,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  LOGS_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(LOGS_SERVICES):;@:)
endif
.PHONY: logs
logs:
	docker-compose $(COMPOSE_FILES) logs -f $(LOGS_SERVICES)

.PHONY: tf
tf:
	(cd ./terraform; terraform plan -out plan && terraform apply plan; cd ~;)
