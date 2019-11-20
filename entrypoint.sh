#!/bin/sh -l
set -e

SSH_PATH="$HOME/.ssh"

mkdir -p "$SSH_PATH"
touch "$SSH_PATH/known_hosts"

if [ -z "$DEPLOY_KEY" ];
then
  echo ::set-output name=status::'The DEPLOY_KEY secret was not set.'
  exit 1
else
  printf '%b\n' "$DEPLOY_KEY" > "$SSH_PATH/deploy_key"
fi

chmod 700 "$SSH_PATH"
chmod 600 "$SSH_PATH/known_hosts" "$SSH_PATH/deploy_key"

eval "$(ssh-agent)"
ssh-add "$SSH_PATH/deploy_key"

if ! sh -c "rsync $1 -e 'ssh -i $SSH_PATH/deploy_key -p $2 -o StrictHostKeyChecking=no' $GITHUB_WORKSPACE/$3 $4"
then
  echo ::set-output name=status::'Deployment failed.'
  exit 1
else
  echo ::set-output name=status::'Deployment successful.'
fi
