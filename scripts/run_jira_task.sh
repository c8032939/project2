#!/usr/bin/env bash
set -euo pipefail

# Wrapper to run a Jira-linked Codex task from the current repo and then
# finalize Jira once the PR exists.
#
# Required env vars:
#   JIRA_SITE   e.g. https://example.atlassian.net
#   JIRA_EMAIL
#   JIRA_TOKEN
#
# Optional env vars:
#   GH_REPO     default: c8032939/project2
#   CODEX_BIN   default: codex
#   SSH_KEY     default: /home/openclaw/.ssh/id_ed25519_github
#
# Usage:
#   ./scripts/run_jira_task.sh P2-12 "Implement the base go_router navigation strategy for web and mobile"

TASK_KEY="${1:-}"
TASK_PROMPT="${2:-}"

if [[ -z "$TASK_KEY" || -z "$TASK_PROMPT" ]]; then
  echo "Usage: $0 <JIRA_KEY> \"<codex task prompt>\"" >&2
  exit 1
fi

: "${JIRA_SITE:?JIRA_SITE is required}"
: "${JIRA_EMAIL:?JIRA_EMAIL is required}"
: "${JIRA_TOKEN:?JIRA_TOKEN is required}"

GH_REPO="${GH_REPO:-c8032939/project2}"
CODEX_BIN="${CODEX_BIN:-codex}"
SSH_KEY="${SSH_KEY:-/home/openclaw/.ssh/id_ed25519_github}"
REPO_DIR="$(git rev-parse --show-toplevel)"
START_TS="$(date -u +%s)"
STARTED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

auth_header() {
  printf '%s' "$JIRA_EMAIL:$JIRA_TOKEN" | base64 -w0
}

jira_api() {
  local method="$1"
  local path="$2"
  local data="${3:-}"
  local auth
  auth="$(auth_header)"
  if [[ -n "$data" ]]; then
    curl -fsS -X "$method" \
      -H "Authorization: Basic $auth" \
      -H "Accept: application/json" \
      -H "Content-Type: application/json" \
      --data "$data" \
      "$JIRA_SITE$path"
  else
    curl -fsS -X "$method" \
      -H "Authorization: Basic $auth" \
      -H "Accept: application/json" \
      "$JIRA_SITE$path"
  fi
}

jira_transition() {
  local issue="$1"
  local transition_id="$2"
  jira_api POST "/rest/api/3/issue/$issue/transitions" "{\"transition\":{\"id\":\"$transition_id\"}}" >/dev/null
}

jira_comment() {
  local issue="$1"
  local text="$2"
  local body
  body=$(python3 - <<'PY' "$text"
import json, sys
text=sys.argv[1]
print(json.dumps({
  "body": {
    "type":"doc",
    "version":1,
    "content":[{"type":"paragraph","content":[{"type":"text","text": text}]}]
  }
}))
PY
)
  jira_api POST "/rest/api/3/issue/$issue/comment" "$body" >/dev/null
}

jira_worklog() {
  local issue="$1"
  local seconds="$2"
  local comment="$3"
  local body
  body=$(python3 - <<'PY' "$seconds" "$comment"
import json, sys
seconds=int(sys.argv[1])
comment=sys.argv[2]
print(json.dumps({
  "timeSpentSeconds": seconds,
  "comment": {
    "type":"doc",
    "version":1,
    "content":[{"type":"paragraph","content":[{"type":"text","text": comment}]}]
  }
}))
PY
)
  jira_api POST "/rest/api/3/issue/$issue/worklog" "$body" >/dev/null
}

echo "==> Setting $TASK_KEY to In Progress"
jira_transition "$TASK_KEY" 31 || true
jira_comment "$TASK_KEY" "Implementation started on branch $TASK_KEY. OpenClaw wrapper will track actual time spent from In Progress to In Review." || true

echo "==> Syncing local repo to latest origin/master"
cd "$REPO_DIR"
GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git fetch origin

git checkout master
GIT_SSH_COMMAND="ssh -i $SSH_KEY -o IdentitiesOnly=yes" git reset --hard origin/master

git checkout -B "$TASK_KEY"

echo "==> Running Codex"
"$CODEX_BIN" exec --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox -C "$REPO_DIR" "
Work on Jira task $TASK_KEY.

Follow AGENTS.md strictly.

Workflow constraints:
- Jira status is already set to In Progress by the wrapper.
- Branch name must be exactly $TASK_KEY.
- Start from the latest origin/master. The wrapper already created the branch correctly.
- Do not move Jira status yourself; the wrapper will handle In Review after PR creation.
- Before opening a PR, perform a self-review.
- After the PR is opened, a separate review run will happen.
- Do not merge to master.

Implementation goal:
$TASK_PROMPT

What to do:
1. Implement the task carefully and keep scope limited to this Jira task.
2. Run formatting and relevant tests/checks.
3. Perform a self-review and address issues you find.
4. Commit the work with a clear commit message referencing $TASK_KEY.
5. Push the branch and open a PR to master.
6. Add a Jira comment with a concise summary and PR link.
7. At the end, print: branch name, base commit used, commit hash, PR link, tests run, and any notes.
"

echo "==> Looking up PR for branch $TASK_KEY"
PR_JSON="$(gh pr list --repo "$GH_REPO" --head "$TASK_KEY" --state open --json number,url,title | tr -d '\n')"
PR_URL="$(python3 - <<'PY' "$PR_JSON"
import json, sys
items=json.loads(sys.argv[1])
print(items[0]['url'] if items else '')
PY
)"

if [[ -n "$PR_URL" ]]; then
  echo "==> Setting $TASK_KEY to In Review"
  jira_transition "$TASK_KEY" 51 || true
  jira_comment "$TASK_KEY" "Implementation is ready for review. PR: $PR_URL" || true
else
  echo "Warning: no open PR found for branch $TASK_KEY" >&2
fi

END_TS="$(date -u +%s)"
SPENT="$((END_TS - START_TS))"
if (( SPENT > 0 )); then
  jira_worklog "$TASK_KEY" "$SPENT" "Logged actual implementation time used by Codex for $TASK_KEY from In Progress to In Review." || true
fi

echo "==> Done"
echo "Task: $TASK_KEY"
echo "PR: ${PR_URL:-<none>}"
echo "Time spent seconds: $SPENT"
