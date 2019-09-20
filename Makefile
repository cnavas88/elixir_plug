PROJECT = elixir_plug

build:
	docker build -t $(PROJECT):$(VERSION) .

up:
	docker run -d -p 80:4001 --name $(PROJECT) $(PROJECT):$(VERSION)