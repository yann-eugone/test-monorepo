#!/usr/bin/env bash

set -e
set -x

# Make sure the branch is provided.
if (( "$#" != 1 ))
then
    echo "Branch has to be provided."

    exit 1
fi

BRANCH=$1

function split()
{
    SHA1=`./bin/splitsh-lite --prefix=$1`
    git push $2 "$SHA1:refs/heads/$BRANCH" -f
}

function remote()
{
    git remote add $1 $2 || true
}

remote split-a git@github.com:yann-eugone/test-monorepo-split-a.git
remote split-b git@github.com:yann-eugone/test-monorepo-split-b.git

split 'packages/split-a' split-a
split 'packages/split-b' split-b
