## Installation

- Run this script from your terminal to install necessary packages.:

```sh
bash <(curl -s https://raw.githubusercontent.com/Alexis12119/dotfiles/main/install.sh)
```

## Firefox

### Theme

- Install this [Theme](https://addons.mozilla.org/en-US/firefox/addon/matte-black-v1/?utm_content=addons-manager-reviews-link&utm_medium=firefox-browser&utm_source=firefox-browser).

### Enable Firefox Customization

- Type `about:config` in the address bar and press `Enter`.
  - A warning page may appear. `Click Accept the Risk and Continue` to go to the `about:config` page.
- Search for the `toolkit.legacyUserProfileCustomizations.stylesheets` preference and set it back to false by clicking on Reset button.
- Clone this [repository](https://github.com/CristianDragos/FirefoxThemes) in your home directory.

```sh
git clone https://github.com/CristianDragos/FirefoxThemes.git
```

- Move the files of `Simply Dark` to `~/.mozilla/firefox/*.default-release/chrome`.

```sh
mv -f ~/FirefoxThemes/SimplyDark/* ~/.mozilla/firefox/*.default-release/chrome
```

Install [HyprDots](https://github.com/prasanthrangan/hyprdots)

```
git clone --depth 1 https://github.com/prasanthrangan/hyprdots ~/HyDE
cd ~/HyDE/Scripts
./install.sh
```
