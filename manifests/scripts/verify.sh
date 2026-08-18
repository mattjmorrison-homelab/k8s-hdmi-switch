#!/bin/sh
set -eu

apk add --no-cache curl jq >/dev/null

check_commit_sha() {
  URL="$1"
  EXPECTED="$2"
  RESPONSE=$(curl -s -o /tmp/response.json -w "%{http_code}" "$URL")

  if [ "$RESPONSE" != "200" ]; then
    echo "FAIL: expected status 200 from $URL, got $RESPONSE"
    exit 1
  fi

  DEPLOYED_COMMIT_SHA=$(jq -r '.commit_sha' /tmp/response.json)

  if [ "$DEPLOYED_COMMIT_SHA" != "$EXPECTED" ]; then
    echo "FAIL: $URL reports commit $DEPLOYED_COMMIT_SHA, expected $EXPECTED"
    exit 1
  fi

  echo "PASS: $URL is running expected commit $EXPECTED"
}

check_commit_sha "https://graph-hdmi-switch.morrisons.site/version" "$EXPECTED_BACKEND_COMMIT_SHA"
check_commit_sha "https://hdmi-switch.morrisons.site/version.json" "$EXPECTED_UI_COMMIT_SHA"
