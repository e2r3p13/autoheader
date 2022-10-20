# autoheader

Neovim plugin to add/update header in source code files. Originally made for our [kfs](https://github.com/lfakau/kfs).

## Installation (with packer)

FIrst clone the repo:
```
git clone git@github.com:lfalkau/autoheader
```

Then in your packer plugin file for your neovim config, add:
```
use '~/path/to/autoheader/'
```
and save to install it.

## Usage:

- `:AddHeader` Adds the header on top of a file
- `:UpdHeader` Updates the header

You can also call the `Setup()` method from your `init.lua` file, to add an autocommand that will trigger the `:UpdHeader` command on `:w`.

Exemple:
```
local status_ok, autoheader = pcall(require, "autoheader")
if not status_ok then
	vim.notify("autoheader not installed")
	return
end

autoheader.Setup()

```

### Notes
The name/mail from the headers are the ones in your git config.
