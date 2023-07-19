DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS repositories;
DROP TABLE IF EXISTS issues;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS pullrequests;
DROP TABLE IF EXISTS projectcards;

CREATE TABLE IF NOT EXISTS users(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    project_v2 VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS repositories(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    owner VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS issues(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    url TEXT NOT NULL,
    title TEXT NOT NULL,
    closed TINYINT(1) NOT NULL DEFAULT 0,
    number INT NOT NULL,
    author VARCHAR(255) NOT NULL,
    repository VARCHAR(255) NOT NULL,
    CHECK (closed IN (0, 1)),
    FOREIGN KEY (repository) REFERENCES repositories(id),
    FOREIGN KEY (author) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS projects(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    title VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    number INT NOT NULL,
    owner VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS pullrequests(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    base_ref_name VARCHAR(255) NOT NULL,
    closed TINYINT(1) NOT NULL DEFAULT 0,
    head_ref_name VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    number INT NOT NULL,
    repository VARCHAR(255) NOT NULL,
    CHECK (closed IN (0, 1)),
    FOREIGN KEY (repository) REFERENCES repositories(id)
);

CREATE TABLE IF NOT EXISTS projectcards(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    project VARCHAR(255) NOT NULL,
    issue VARCHAR(255),
    pullrequest VARCHAR(255),
    FOREIGN KEY (project) REFERENCES projects(id),
    FOREIGN KEY (issue) REFERENCES issues(id),
    FOREIGN KEY (pullrequest) REFERENCES pullrequests(id),
    CHECK (issue IS NOT NULL OR pullrequest IS NOT NULL)
);

INSERT INTO users(id, name) VALUES
    ('U_1', 'hsaki')
;

INSERT INTO repositories(id, owner, name) VALUES
    ('REPO_1', 'U_1', 'repo1')
;

INSERT INTO issues(id, url, title, closed, number, author, repository) VALUES
    ('ISSUE_1', 'http://example.com/repo1/issue/1', 'First Issue', 1, 1, 'U_1', 'REPO_1'),
    ('ISSUE_2', 'http://example.com/repo1/issue/2', 'Second Issue', 0, 2, 'U_1', 'REPO_1'),
    ('ISSUE_3', 'http://example.com/repo1/issue/3', 'Third Issue', 0, 3, 'U_1', 'REPO_1'),
    ('ISSUE_4', 'http://example.com/repo1/issue/4', '', 0, 4, 'U_1', 'REPO_1'),
    ('ISSUE_5', 'http://example.com/repo1/issue/5', '', 0, 5, 'U_1', 'REPO_1'),
    ('ISSUE_6', 'http://example.com/repo1/issue/6', '', 0, 6, 'U_1', 'REPO_1'),
    ('ISSUE_7', 'http://example.com/repo1/issue/7', '', 0, 7, 'U_1', 'REPO_1')
;

INSERT INTO projects(id, title, url, number, owner) VALUES
    ('PJ_1', 'My Project', 'http://example.com/project/1', 1, 'U_1'),
    ('PJ_2', 'My Project 2', 'http://example.com/project/2', 2, 'U_1')
;

INSERT INTO pullrequests(id, base_ref_name, closed, head_ref_name, url, number, repository) VALUES
    ('PR_1', 'main', 1, 'feature/kinou1', 'http://example.com/repo1/pr/1', 1, 'REPO_1'),
    ('PR_2', 'main', 0, 'feature/kinou2', 'http://example.com/repo1/pr/2', 2, 'REPO_1')
;
