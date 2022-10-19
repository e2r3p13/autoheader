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

### Notes
The name/mail from the headers are the ones in your git config.
