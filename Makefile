.PHONY: up down iex deps ecto test

up:
	docker-compose up

down:
	docker-compose down

iex:
	docker-compose run web iex -S mix

deps:
	docker-compose run web mix do deps.get, deps.compile

ecto:
	docker-compose run web mix do ecto.create, ecto.migrate

test:
	docker-compose run web mix test
