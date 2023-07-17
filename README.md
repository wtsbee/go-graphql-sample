# go-graphql-sample

`gqlgen`のインストール

```
$ go install github.com/99designs/gqlgen@latest
```

サンプルコードの生成

```
$ go mod init my_gql_server
$ go get -u github.com/99designs/gqlgen
$ gqlgen init
```

GraphQL サーバーの起動

```
$ go run ./server.go
```

Playground へのアクセス

```
http://localhost:8081/
```

slqboiler のインストール

```
$ go install github.com/volatiletech/sqlboiler/v4@latest
```

driver のインストール(今回は MySQL)

```
$ go install github.com/volatiletech/sqlboiler/v4/drivers/sqlboiler-mysql@latest
```
