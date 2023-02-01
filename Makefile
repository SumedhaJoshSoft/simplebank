postgres:
	docker run --name postgres12alpine -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres12alpine createdb --username=root --owner=root simplebank

dropdb:
	docker exec -it postgres12alpine dropdb simplebank

migreateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable" -verbose up

migreatedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simplebank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migreateup migreatedown sqlc



