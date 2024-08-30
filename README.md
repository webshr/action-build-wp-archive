# WordPress Build Archive GitHub Action

A GitHub Action to generate a zip archive of a WordPress project using [WP-CLI](https://developer.wordpress.org/cli/commands/dist-archive/).

### Usage Example

Place the following in `/.github/workflows/main.yml`

```yml
on: push
name: 🚀 Build WordPress Plugin on Push
jobs:
  build-deploy:
    name: 🎉 Build archive
    runs-on: ubuntu-latest
    steps:
      - name: 🚚 Checkout latest code
        uses: actions/checkout@v4

      - name: 📦 Build Plugin
        uses: webshr/deploy-wp-update-server@latest
        with:
          install-composer: true # optional; defaults to false
          npm-run-build: true # optional; defaults to false
          node-version: 20 # optional; defaults to '18.x'
          retention-days: 5 # optional; defaults to 30
          archive-name: my-plugin # optional; defaults to repository-name
```

## Excluding files from the archive

You can specify files or directories to be excluded from an archive using a `.distignore` or a `.gitattributes` file. It's recommended to use a `.distignore` file, especially for built files in `.gitignore`. The `.gitattributes` file is useful for projects that don't run a build step and ensures consistency with files committed to WordPress.org.

`.gitignore` example:

```.gitignore
/.wordpress-org
/.git
/node_modules

.distignore
.gitignore
```

`.gitattributes` example:

```.gitattributes
# Directories
/.github export-ignore

# Files
/.gitattributes export-ignore
/.gitignore export-ignore
```

### Configuration

Add your keys directly to your .yml configuration file or referenced from the `Secrets` project store.

It is strongly recommended to save sensive credentials as secrets.


| **Key Name**       | **Required** | **Example** | **Default**       | **Description**                               |
| ------------------ | ------------ | ----------- | ----------------- | --------------------------------------------- |
| `install-composer` | no           | `true`      | `false`           | Install composer before generating archive    |
| `npm-run-build`    | no           | `true`      | `false`           | Run `npm run build` before generating archive |
| `node-version`     | no           | `20`        | `18`              | Node version                                  |
| `retention-days`   | no           | `3`         | `30`              | Number of days to retain the arhive           |
| `archive-name`     | no           | `my-plugin` | `repository-name` | Name of the zip archive                       |

### Credits

This action is inspired by and builds upon the work done in the [Generate WordPress Archive](https://github.com/rudlinkon/action-wordpress-build-zip) and [WordPress Plugin Build Zip](https://github.com/10up/action-wordpress-plugin-build-zip) Actions.

### Further Reading

* [Official WP-CLI Command documentation](https://developer.wordpress.org/cli/commands/dist-archive/) for ``wp dist-archive`

### License

This action is licensed under the MIT License.