# Rails Best Practices Boilerplate 2022

Ruby on Rails boilerplate configured with the most useful gems and best practices. It comes with the latest Ruby (v3.1.3) and Rails(v7.0.2) versions as of September 2022.

#### This boilerplate consists of the following

1. User Authentication with Routes using JWT tokens ([devise](https://github.com/jinzhu/devise) & [devise-jwt](https://github.com/waiting-for-dev/devise-jwt)).
2. Dockerfiles & Docker-Compose files for both local & production environments
3. Configured Database - Postgres
4. Parameter validations using [rails-param](https://github.com/nicolasblanco/rails_param)
5. [bullet](https://github.com/flyerhzm/bullet) gem for N+1 query finder
6. Case conversion of incoming & outgoing data using [oj](https://github.com/ohler55/oj) & [olive_branch](https://github.com/vigetlabs/olive_branch)
7. [dot-env](https://github.com/bkeepers/dotenv) gem for loading Environment files
8. [whenever](https://github.com/javan/whenever) gem for Cron Jobs
9. [activerecord-import](https://github.com/zdennis/activerecord-import) for bulk save & update queries
10. This repo also contains few best practices to follow.

Refer to the following article to understand the best practices in detail:
[Ruby on Rails - Best Practices Every Developer Should Know](https://karanjagtiani.medium.com/ruby-on-rails-best-practices-every-developer-should-know-ebff44e87da2)

## Prerequisites

- Ruby - v3.1.2
- Docker - (Optional, but good to have)

## How to Run

#### 1. Using Docker

```bash
docker compose up -d
```

Rails application will be running at `localhost:8085`

#### 2. Non-Docker method

Configure your local Postgres instance and make changes accordingly in the `.env.development` file

```
DB_HOST=...
DB_USER=...
DB_PASSWORD=...
DB_PORT=...
```

Then run the following command:

```bash
rails s
```

Rails application will be running at `localhost:8080`
