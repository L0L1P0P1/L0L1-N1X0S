# NixOS Configuration

This repository contains my personal NixOS configuration files, organized to support multiple hosts and modular components. It uses the Nix flakes system for reproducibility and ease of management.

### Key Directories 
- **`flake.nix`** and **`flake.lock`**: The main flake file defines system inputs and outputs. The lock file ensures reproducibility.
- **`hosts/`**: Contains machine-specific configurations. Each host has its own NixOS and optional Home Manager files.
- **`modules/`**: Custom, reusable Nix modules split into:
- `desktop-apps`: GUI applications and services Nix Modules
- `home-manager`: Home Manager Modules
- `programs`: CLI and development tools including NixVim
- **`LICENSE`**: Repository licensing
- **`README.md`**: This documentation fils

## Usage

### Cloning the Repository

Clone the repository into your NixOS configuration directory (e.g., `PATH_TO_YOUR_NIXOS_CONF/`). Note that because this configuration is flake-based, you can put your configuration anywhere you like:

```bash
git clone https://github.com/L0L1P0P1/L0L1-N1X0S.git PATH_TO_YOUR_NIXOS_CONF/
```

### Applying the Configuration

To apply a specific host configuration using Nix flakes:

```bash
nixos-rebuild switch --flake PATH_TO_YOUR_NIXOS_CONF#<hostname>
```

Replace `<hostname>` with the name of the desired host (e.g., `poolad` or `sitka`).

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
- [ ] Switch to `snacks.picker` or `fzf-lua` for faster picker
- [ ] xdg/memo opening files—opening directories is a pain, e.g.
- [ ] fix suspend for sitka
- [ ] Home Manager modules for `rofi`, `polybar`, `picom`
- [ ] fix function keys for laptop and pc 
- [ ] Notifications with something like `dunst`
- [ ] Customize `starship` prompt
- [ ] Add `molten.nvim` to NixVim
- [ ] Boot Animation For Laptop

Happy hacking with NixOS!
