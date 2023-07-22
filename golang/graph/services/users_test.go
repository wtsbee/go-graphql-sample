package services_test

import (
	"context"
	"my_gql_server/graph/model"
	"my_gql_server/graph/services"
	"testing"

	"github.com/DATA-DOG/go-sqlmock"
	"github.com/google/go-cmp/cmp"
)

func TestGetUserByID(t *testing.T) {
	db, mock, err := sqlmock.New()
	if err != nil {
		t.Fatalf("an error '%s' was not expected when opening a stub database connection", err)
	}
	defer db.Close()

	srv := services.New(db)
	ctx := context.Background()
	mockSetup := func(mock sqlmock.Sqlmock, id, name string) {
		columns := []string{"id", "name"}
		mock.ExpectQuery(".*").WithArgs(id).WillReturnRows(
			sqlmock.NewRows(columns).AddRow(id, name),
		)
	}

	tests := []struct {
		title    string
		id       string
		name     string
		expected *model.User
	}{
		{
			title:    "case1",
			id:       "U_ABC",
			name:     "hsaki",
			expected: &model.User{ID: "U_ABC", Name: "hsaki"},
		},
		{
			title:    "case2",
			id:       "U_DEF",
			name:     "Alice",
			expected: &model.User{ID: "U_DEF", Name: "Alice"},
		},
	}

	for _, tt := range tests {
		t.Run(tt.title, func(t *testing.T) {
			mockSetup(mock, tt.id, tt.name)

			got, err := srv.GetUserByID(ctx, tt.id)
			if err != nil {
				t.Error(err)
			}
			if diff := cmp.Diff(tt.expected, got); diff != "" {
				t.Errorf("GetUserByID() mismatch (-want +got):\n%s", diff)
			}
		})
	}
}
