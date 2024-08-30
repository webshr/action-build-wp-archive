#!/bin/bash

# it does not exit with a 0, and we only care about the final exit.
set -eo

# Install WP-CLI
echo '🛠️ Set up WP-CLI'
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
echo '✅ Successfully installed WP-CLI'

# Install dist-archive command
echo '🛠️ Set up dist-archive-command'
wp package install wp-cli/dist-archive-command --allow-root
echo '✅ Successfully installed dist-archive-command'

# Install Composer if requested
if [ "$INSTALL_COMPOSER" = "true" ]; then
  echo "🛠️ Set up composer"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  php -r "unlink('composer-setup.php');"
  echo '✅ Successfully installed Composer'

  # Install Composer dependencies if composer.json exists
  if [ -f "composer.json" ]; then
    echo "📦 Install Composer dependencies"
    composer install
    echo '✅ Successfully installed Composer dependencies'
  fi
fi

# Run npm build if requested
if [ "$NPM_RUN_BUILD" = "true" ] && [ -f "package.json" ]; then
  echo "📦 Install npm dependencies"
  npm install
  echo '✅ Successfully installed npm packages'
  echo "✨Running npm build..."
  npm run build
  echo '✅ Successfully run npm build'
fi

# Generate WordPress Archive
echo '🏗️ Generate archive file✨'
wp dist-archive . ./"${ARCHIVE_NAME}.zip" --allow-root
echo '🎉 Successfully generated archive file'
