# mds4all
Minimalistic and free *m*odern *d*ata *s*tack, hence *for all*.

- [`one-data-cookie/mds4all-elt`](https://github.com/one-data-cookie/mds4all-elt):
  - Warehousing: [Google BigQuery](https://cloud.google.com/bigquery/)
  - Orchestrating: [Github Actions](https://github.com/features/actions)
  - Ingesting: [Meltano](https://meltano.com/)
  - Transforming: [dbt](https://www.getdbt.com/)
  - Cataloging: [dbt docs](https://www.getdbt.com/docs/) on [GitHub Pages](https://pages.github.com/)

- [`one-data-cookie/mds4all-superset`](https://github.com/one-data-cookie/mds4all-superset).
  - Visualising: [Superset](https://superset.apache.org/) on [Heroku](https://dashboard.heroku.com/)

# mds4all-elt
ELT layer of `mds4all`.

## Setup
```shell
### BigQuery
# Log in to project
# install gcloud from https://cloud.google.com/sdk/docs/install
$ gcloud auth login
$ PROJECT_ID=$(gcloud config get-value project)

# Create user and add permissions
$ gcloud iam service-accounts create bigquery-sa --display-name="BigQuery SA"
$ gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:bigquery-sa@${PROJECT_ID}.iam.gserviceaccount.com" --role="roles/bigquery.user"
$ gcloud projects add-iam-policy-binding $PROJECT_ID --member="serviceAccount:bigquery-sa@${PROJECT_ID}.iam.gserviceaccount.com" --role="roles/bigquery.dataEditor"

# Download creds to local
$ gcloud iam service-accounts keys create bigquery-sa.json --iam-account=bigquery-sa@${PROJECT_ID}.iam.gserviceaccount.com

### Meltano
# Test Meltano locally
$ pip install meltano
$ meltano init meltano
$ cd meltano
$ meltano add extractor tap-spreadsheets-anywhere
$ meltano add loader target-bigquery
# add config info about tap and target into meltano.yml
$ meltano elt tap-spreadsheets-anywhere target-postgres

### dbt
# Test dbt locally
$ pip install dbt-bigquery
$ dbt init
# set up files
$ dbt debug
$ dbt run
$ dbt test
$ dbt docs generate
$ dbt docs serve
```

## Limitations
- Public repository
- Public documentation
- Warehousing with 100 GB of storage and 1 TB of queries 

## Inspiration
- [Data Stacks For Fun & Nonprofit — Part III](https://towardsdatascience.com/data-stacks-for-fun-nonprofit-part-iii-dcfd46da9f9f)
- [How to Deploy dbt to Production using GitHub Actions](https://towardsdatascience.com/how-to-deploy-dbt-to-production-using-github-action-778bf6a1dff6)
- [Deploy the docs for your dbt package](https://docs.getdbt.com/docs/guides/building-packages#5-deploy-the-docs-for-your-package)
