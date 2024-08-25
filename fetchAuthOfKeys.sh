#!/bin/bash

# 1. Get the list of IAM Service Accounts
service_accounts=$(gcloud iam service-accounts list --format='value(email)')

# 2. Iterate through each service account to get user-managed keys
for account in $service_accounts; do
    keys=$(gcloud iam service-accounts keys list --iam-account=$account --managed-by=user --format='value(name)')
  
    # 3. If there are user-managed keys, query their last authentication dates
    if [[ ! -z "$keys" ]]; then  # Check if $keys is not empty
        for key in $keys; do
            last_auth=$(gcloud policy-intelligence query-activity \
                --activity-type=serviceAccountKeyLastAuthentication \
                --project=YOUR_PROJECT_NAME \
                --query="query.serviceAccountKeyName=\"$key\"" \
                --limit=1 \
                --format='value(timestamp)')

            # If last_auth is not empty, print the information
            if [[ ! -z "$last_auth" ]]; then
                echo "Service Account: $account, Key: $key, Last Authentication: $last_auth"
            else
                echo "Service Account: $account, Key: $key, Last Authentication: Not Found"
            fi
        done
    fi
done
