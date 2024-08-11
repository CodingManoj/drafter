# drafter

jq -r '.bindings[] | select(.role | IN("roles/owner", "roles/editor", "roles/viewer")) | .members[] | select(startswith("serviceAccount:"))' iam_policy.json


jq -r 'keys[] | select(startswith("serviceAccount:")) | .[] | select(.role | IN("roles/owner", "roles/editor", "roles/viewer"))' iam_policy.json

gcloud projects get-iam-policy <PROJECT_ID> --flatten="bindings[].members" --filter="bindings.members~'serviceAccount:' AND (bindings.role='roles/owner' OR bindings.role='roles/editor')" --format="value(bindings.members)"



```
gcloud scc findings list \
    --project=YOUR_PROJECT_ID \
    --filter="category=\"USER_MANAGED_SERVICE_ACCOUNT_KEY\" AND findingClass=\"MISCONFIGURATION\"" \
    --format="table(name, category, findingClass, state, eventTime)"

```
