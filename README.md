<p align="center">
  <a href="#gh-dark-mode-only" target="_blank" rel="noopener noreferrer">
    <img src=".github/assets/night.svg" alt="laravel.plugin.zsh">
  </a>

  <a href="#gh-light-mode-only" target="_blank" rel="noopener noreferrer">
    <img src=".github/assets/day.svg" alt="laravel.plugin.zsh">
  </a>
</p>

Plugin for skiping the `php` command when running artisan commands and `./sail` or `./vendor/bin/sail` when running sail commands.

## Installation

```bash
# Using oh-my-zsh
git clone https://github.com/baliestri/laravel.plugin.zsh.git $ZSH_CUSTOM/plugins/laravel.plugin.zsh
# Add laravel to the plugins array in your zshrc file.

# Using zinit
zinit light baliestri/laravel.plugin.zsh

# Using zi
zi light baliestri/laravel.plugin.zsh
```

## Usage

```bash
cd /path/to/laravel/project # laravel subdirectory
artisan # instead of php artisan
sail # instead of ./sail or ./vendor/bin/sail
```
