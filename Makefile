COMPOSE_FILES=-f database.yml -f infra.yml -f dataload.yml

ifeq (build,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  BUILD_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(BUILD_SERVICES):;@:)
endif
.PHONY: build
build:
	docker-compose $(COMPOSE_FILES) build --no-cache $(BUILD_SERVICES)

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

ifeq (sh,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  SH_SERVICES := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(SH_SERVICES):;@:)
endif
.PHONY: sh
sh:
	docker-compose $(COMPOSE_FILES) exec $(SH_SERVICES) sh

ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif
.PHONY: run
run:
	docker-compose $(COMPOSE_FILES) run $(RUN_ARGS)
