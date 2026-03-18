# System Settings and Apps

## Finder

- Finder > Settings > General > Show these items on the desktop > Hard disks
- Finder > neil > Drag `src` directory to the sidebar

## System Settings

- Appearance
  - Appearance -> Auto
  - Sidebar icon size -> Small
  - Show scroll bars -> When Scrolling
- Desktop and Dock
  - Small size
  - No magnification
  - Minimize windows using -> Scale effect
  - Automatically hide and show the Dock
  - Default web browser -> Google Chrome
- Displays
  - Configure external monitors
- Keyboard
  - Keyboard
    - Key repeat -> Fast
    - Delay until repeat -> Short
    - Modifier Keys -> Microsoft Nano Tranceiver -> (Option = Command, Command = Option)
  - Shortcuts
    - Enable: Use keyboard navigation to move focus between controls
    - All Applications
      - Lock Screen = `Option + Command + L`
    - Mission Control
      - Show Desktop = `Shift + Command + \`
    - App Shortcuts
      - "Messages -> Delete Conversation..." = `Shift + Command + D`
    - Screenshots
      - Disable Save picture of screen as file
      - Disable Copy picture of screen to the clipboard
- Trackpad
  - Disable: Scroll direction natural -> disable
  - Enable: Smart zoom -> double-tap with two fingers
- Mouse
  - Disable: Scroll direction natural
  - Enable: Secondary click -> Click on the right side
- Notifications
  - Facetime
    - Disable: Play sound for notifications

## Ghostty

Use the Ghostty config file at `./static/ghostty.config`.

## iTerm2

Continue using iTerm2 as well until Ghostty supports using TouchID for the 1Password CLI.

### Load the Personal Profile

- iTerm
  - Profiles
    - Load Profile from `~/src/github.com/dahlke/eklhad-config/static/eklhad_iterm.json`

### Setup Appearance

- iTerm
  - Appearance
    - General
      - Theme = Dark
      - Tab bar = Top
      - Status bar = Top
      - General Auto-Hide menu bar in non-native fullscreen

### Setup Key Bindings

- iTerm
  - Keys
    - Select Split Plane on Left = `Command + H`
    - Select Split Plane on Right = `Command + L`
    - Select Split Plane Above = `Command + K`
    - Select Split Plane Below = `Command + J`

## Magnet

_NOTE: Once MacOS Windows supports splitting into 3rds, I don't need Magnet anymore.__

- Magnet
  - Preferences
    - Left = `Shift + Command + H`
    - Right = `Shift + Command + L`
    - Up = `Shift + Command + K`
    - Down = `Shift + Command + J`
    - Left Third = `Shift + Command + 1`
    - Center Third = `Shift + Command + 2`
    - Right Third = `Shift + Command + 3`
    - Next Display = `Control + Shift + Command + 1`
    - Previous Display = `Control + Shift + Command + 1`
    - Maximize = `Shift + Command + M`
    - Enable launch on login

## Messages

Be sure to setup [text message forwarding](https://support.apple.com/en-us/HT208386) from iPhone, and disable sound effects.

## iStat Menus

Apply the license from email, and then enable: Notifications, CPU & CPU, Memory, Disks, Network and Battery/Power. Start on bootup.

## Removed Unused Mac Apps

At this stage, start to remove the applications that you will not use as they are just clutter.
