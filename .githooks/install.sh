#!/usr/bin/env bash
# Run once after cloning to enable the project's git hooks.
set -e
git config core.hooksPath .githooks
echo "✓ Git hooks enabled. Pre-commit checks will now run before each commit."
