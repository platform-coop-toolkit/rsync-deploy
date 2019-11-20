# Rsync Deploy

This GitHub Action deploys content to a remote server using [rsync](https://rsync.samba.org/). It's a fork of [Pendect/action-rsyncer](https://github.com/Pendect/action-rsyncer) which adds support for custom SSH ports.

## Usage

Add an SSH public key to the server.

Add the corresponding private key to the repository as an [encrypted secret](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/creating-and-using-encrypted-secrets) named `DEPLOY_KEY`.

In `.github/workflows/<your-workflow-name>.yml`, add the following steps:

```yml
- name: Deploy to server
  id: deploy
  uses: platform-coop-toolkit/rsync-deploy@master
  env:
    DEPLOY_KEY: ${{secrets.DEPLOY_KEY}}
  with:
    flags: '-azrh --delete' # rsync flags (default: '-azrh')
    port: '' # SSH port (default: 22)
    src: 'build/' # Local path to deploy, relative to $GITHUB_WORKSPACE (default: '')
    dest: 'user@example.com:/var/www/example.com'

- name: Display deployment status
  run: echo "${{ steps.deploy.outputs.status }}"
```
