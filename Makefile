GOCMD=go
GOTEST=$(GOCMD) test
GOLINT=golangci-lint
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
BINARY_NAME=hoge

all: lint test

test:
	$(GOTEST) -v ./...

lint:
	$(GOLINT) run -v ./...

build:
	$(GOBUILD) -o $(BINARY_NAME) -v

clean:
	$(GOCLEAN) ./...
	rm $(BINARY_NAME)

# For local
ci.l.check:
	circleci config validate .circleci/config.yml

ci.l.test:
	circleci config process .circleci/config.yml > ci_local.yml
	circleci build --job test -c ci_local.yml
