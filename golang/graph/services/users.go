package services

import (
	"context"
	"my_gql_server/graph/db"
	"my_gql_server/graph/model"

	"github.com/volatiletech/sqlboiler/v4/boil"
	"github.com/volatiletech/sqlboiler/v4/queries/qm"
)

type userService struct {
	exec boil.ContextExecutor
}

func convertUser(user *db.User) *model.User {
	return &model.User{
		ID:   user.ID,
		Name: user.Name,
	}
}

func (u *userService) GetUserByName(ctx context.Context, name string) (*model.User, error) {
	// SQLBoilerで生成されたORMコードを呼び出す
	user, err := db.Users(
		qm.Select(db.UserTableColumns.ID, db.UserTableColumns.Name), // select id, name
		db.UserWhere.Name.EQ(name),                                  // where name = {引数nameの内容}
	).One(ctx, u.exec) // limit 1
	// 2. エラー処理
	if err != nil {
		return nil, err
	}
	return convertUser(user), nil
}
