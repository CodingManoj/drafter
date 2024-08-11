#!/bin/bash

# Get the GCP project ID (replace with your project ID)
PROJECT_ID="your-gcp-project-id"

# List service accounts with keys and their creation dates
gcloud iam service-accounts list --project $PROJECT_ID --format="value(email)" \
| while read SERVICE_ACCOUNT; do
    KEYS=$(gcloud iam service-accounts keys list --iam-account $SERVICE_ACCOUNT --project $PROJECT_ID --format="value(name,validAfterTime)")
    if [[ ! -z "$KEYS" ]]; then
        echo "Service Account: $SERVICE_ACCOUNT"
        echo "$KEYS"

        # Get attached IAM roles
        ROLES=$(gcloud projects get-iam-policy $PROJECT_ID --format="json" | jq -r '.bindings[] | select(.members[] | contains("serviceAccount:'$SERVICE_ACCOUNT'")) | .role')
        if [[ ! -z "$ROLES" ]]; then
            echo "Attached IAM Roles:"
            echo "$ROLES"
        fi

        echo ""
    fi
done
