gcloud policy-intelligence query-activity \
  --activity-type=serviceAccountKeyLastAuthentication \
  --project=projectNAME \
  --limit=1000 \
  --format=json | jq -r '.[] | {lastAuthenticatedTime: .timestamp, fullResourceName: .fullResourceName} | @json'
