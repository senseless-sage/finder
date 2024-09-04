### Finder is a CLI tool for fuzzy searching local files.

## Getting started
1. Install fish shell, tree, bat and fd
2. Download finder
3. Run ./finder/setup.fish

## Usage

https://github.com/user-attachments/assets/5adc4008-fc4c-49ab-bed7-39fb4802d8ea

## Key bindings inside fish
- **ctrl + f** : **Find** all **files** in the current directory **recursively**.
- **ctrl + d** : **Find** all **directories** in the current directory **recursively**.
- **alt + d** : Find all **directories** in the current directory **recursively** and **cd** into the selected one.
- **ctrl + r** : Find all **files** in the current directory **recursively** and **read** the selected one via bat.
- **ctrl + e** : Find all **files** in the current directory **recursively** and **edit** the selected one via micro.
- **ctrl + o** : Find all **files** in the current directory **recursively** and **open** the selected one via xdg-open.
---
- **alt + f** : **Find** all **files and directories** in the **current directory**.
- **alt + r** : Find all **files and directories** in the **current directory** and **read** the selected one via bat.
- **alt + e** : Find all **files and directories** in the **current directory** and **edit** the selected one via micro.
- **alt + o** : Find all **files and directories** in the **current directory** and **open** the selected one via xdg-open.
---
- **alt + shift + f** : **Find** all **files** in the **$HOME directory** recursively.
- **alt + shift + d** : **Find** all **directories** in the **$HOME** directory recursively.
- **alt + shift + r** : Find all **files** in the **$HOME** directory recursively and **read** the selected one via bat.
- **alt + shift + e** : Find all **files** in the **$HOME** directory recursively and **edit** the selected one via micro.
- **alt + shift + o** : Find all **files** in the **$HOME** directory recursively and **open** the selected one via xdg-open.
---
- **ctrl + h** : Opens your fish history.
## Key bindings inside search mode (fzf)
- **tab** : Select the current entry and move down.
- **tab + shift** : Select the current entry and move up.
- **ctrl + r** : **Refresh** the file index. (update the list of files and dirs, use if your local files have changed)
- **ctrl + a** : Select all.
- **ctrl + d** : Deselect all.
- **ctrl + t** : Toggle / inverse selected entries.
- **ctrl + y** : Copy entry into system clipboard.

## Search starting path
The search starting point defaults to the current path, but
you can control the starting path for your search by explicitly typing it before starting the search.

Example copying a file from the current directory to another, which is not a subdirectory:
```
$ pwd
/tmp/chromium-main/third_party/blink/renderer/platform/webrtc
$ cp ./webrtc_logging.cc /tmp/chromium-main**now press ctrl + d to start the search from the "/tmp/chromium-main" directory.**
```

## Ignore files and directories
You can ignore files and dirs by adding a fd ignore file.

Example ignore file **"$HOME/.config/fd/ignore"**:
```
/boot/
/lost+found/
/proc/
/root/
/run/
/sbin/
/sys/
/home/user/games/
/home/user/.*/
**/.git/
**/node_modules/
```
