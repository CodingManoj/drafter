# drafter

jq -r '.bindings[] | select(.role | IN("roles/owner", "roles/editor", "roles/viewer")) | .members[] | select(startswith("serviceAccount:"))' iam_policy.json
