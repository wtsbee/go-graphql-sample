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
go run ./server.go
```

Playground へのアクセス

`http://localhost:8081/`
