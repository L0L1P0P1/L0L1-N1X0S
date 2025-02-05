# NixOS Configuration

This repository contains my personal NixOS configuration files, organized to support multiple hosts and modular components. It uses the Nix flakes system for reproducibility and ease of management.

## Repository Structure

```plaintext
nixos
├── flake.lock                 # Lockfile for flake dependencies
├── flake.nix                  # Main entry point for the Nix flake
├── hosts                      # Host-specific configurations
│   ├── merdas                 # Configuration for the host 'merdas'
│   │   ├── configuration.nix
│   │   └── hardware-configuration.nix
│   └── sitka                  # Configuration for the host 'sitka'
│       ├── configuration.nix
│       └── hardware-configuration.nix
├── nixosModules               # Modular NixOS configurations
│   ├── default.nix            # Entry point for custom modules
│   ├── desktopApps            # Desktop applications
│   │   ├── default.nix
│   │   └── droidcamOBS.nix
│   ├── devTools               # Development tools
│   │   └── default.nix
│   ├── nixvim                 # NixVim configuration modules
│   │   ├── alpha.nix
│   │   ├── default.nix
│   │   ├── keymaps.nix
│   │   └── README.md
│   ├── tmux                   # Tmux configuration modules
│   │   ├── default.nix
│   │   └── README.md
│   └── zsh.nix                # Zsh shell configuration
└── README.md                  # YOU ARE HERE!
```

### Key Directories

- **`flake.nix`** and **`flake.lock`**: The main flake file defines the system configuration and dependencies. The lockfile ensures deterministic builds.
- **`hosts/`**: Contains host-specific configurations for individual machines.
- **`nixosModules/`**: Custom Nix modules for reusable configurations, organized by functionality (e.g., `desktopApps`, `devTools`).
- **`nixosModules/nixvim/`**: NixVim Configuration. [NixVim](https://github.com/nix-community/nixvim) is a *Neovim* Distribution and Configuration system built around *Nix* modules. 
- **`README.md`**: Documentation for the repository.

## Usage

### Cloning the Repository

Clone the repository into your NixOS configuration directory (e.g., `PATH_TO_YOUR_NIXOS_CONF/`). Note that because this configuration is flake-based, you can put your configuration anywhere you like:

```bash
git clone <repository-url> PATH_TO_YOUR_NIXOS_CONF/ 
```

### Applying the Configuration

To apply a specific host configuration using Nix flakes:

```bash
nixos-rebuild switch --flake PATH_TO_YOUR_NIXOS_CONF#<hostname>
```

Replace `<hostname>` with the name of the desired host (e.g., `merdas` or `sitka`).

### Updating the System

To update flake inputs and apply the latest changes:

```bash
nix flake update
nixos-rebuild switch --flake /etc/nixos#<hostname>
```

## Contributing

If you'd like to contribute or suggest improvements, feel free to submit a pull request or open an issue. All contributions are welcome!

## License

This configuration repository is distributed under the [MIT License](LICENSE). Feel free to use and adapt it for your own purposes.

---

### Notes

- **Backups**: Ensure regular backups of critical configuration files.
- **Testing Changes**: Use Git branches for experimenting with new configurations to avoid breaking your system.

### TODO
- [ ] Add Homemanager For Managing Dotfiles
- [ ] xdg/memo opening files. opening directories is a pain for e.g.
- [ ] qt/gtk themes
- [ ] Cofigure Display Manager
- [ ] Add Molten For NixVim
- [ ] Add Keybinds For nixvim Neogit
- [ ] Setup store sharing for multiple devices 
- [ ] Add molten.nvim to nixvim 


Happy hacking with NixOS!
