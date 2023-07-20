package services

import (
	"context"
	"log"

	"my_gql_server/graph/db"
	"my_gql_server/graph/model"

	"github.com/volatiletech/sqlboiler/v4/boil"
)

type pullRequestService struct {
	exec boil.ContextExecutor
}

func convertPullRequest(pr *db.Pullrequest) *model.PullRequest {
	prURL, err := model.UnmarshalURI(pr.URL)
	if err != nil {
		log.Println("invalid URI", pr.URL)
	}

	return &model.PullRequest{
		ID:          pr.ID,
		BaseRefName: pr.BaseRefName,
		Closed:      pr.Closed,
		HeadRefName: pr.HeadRefName,
		URL:         prURL,
		Number:      int(pr.Number),
		Repository:  &model.Repository{ID: pr.Repository},
	}
}

func (p *pullRequestService) GetPullRequestByID(ctx context.Context, id string) (*model.PullRequest, error) {
	pr, err := db.FindPullrequest(ctx, p.exec, id,
		db.PullrequestColumns.ID,
		db.PullrequestColumns.BaseRefName,
		db.PullrequestColumns.Closed,
		db.PullrequestColumns.HeadRefName,
		db.PullrequestColumns.URL,
		db.PullrequestColumns.Number,
		db.PullrequestColumns.Repository,
	)
	if err != nil {
		return nil, err
	}
	return convertPullRequest(pr), nil
}
