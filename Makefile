.PHONY: up down iex test

up:
	docker-compose up

down:
	docker-compose down

iex:
	docker-compose run web iex -S mix

test:
	docker-compose run web mix test
