# Fancontrol Debug Log

## Background
You are running an Alienware Aurora R12 with dual-boot Windows 11 & CachyOS Linux (Hyprland). Your setup includes an Intel i9-11900KF, RTX 3080 (proprietary driver), 64 GiB RAM, dual monitors, CachyOS Zen kernel, Hyprland, fish shell, Kitty terminal, and micro editor. You use pacman + paru, and prefer commands formatted fish-friendly. For logs and terminal output, you often pipe to `cgpt` for trimming/cleaning.


## Decisions Made
- Using **fancontrol** with a helper generator script (`/usr/local/bin/fancontrol-generate`) to rewrite `/etc/fancontrol` dynamically.
- Added a `fancontrol-prepare.service` systemd unit to run the generator before `fancontrol.service`.
- Systemd override file was created for `fancontrol.service` to depend on the `fancontrol-prepare.service`.
- Identified that the systemd hardening option `ProtectSystem=full` prevented `/etc/fancontrol` from being regenerated.
- Workaround considered: adjust generator or service so it writes safely without tripping the protection.


## Current Status
- `fancontrol` loads the config but still reports: *Device path of hwmonX has changed* and suggests rerunning `pwmconfig`.
- The generator writes a valid `/etc/fancontrol` manually, but fails under systemd due to `ProtectSystem=full`.
- Service override file had a typo (`Requi res` instead of `Requires`) that was fixed.
- The service sometimes starts, but then `fancontrol` exits because hwmon paths mismatch (likely Dell SMM + coretemp changing indices).


## Open Questions / Next Steps
1. **Fix generator permissions issue**: either adjust service hardening (`ProtectSystem`) or redirect generator output to `/run/fancontrol.conf` and bind-mount into place.
2. **Resolve hwmon path churn**: ensure generator consistently rewrites correct absolute paths at each boot before `fancontrol` starts.
3. **Re-test systemd integration**: confirm `fancontrol-prepare` runs, generates config, and `fancontrol` stays active.
4. **Fallback option**: If hwmon devices keep renumbering unpredictably, consider using `coolercontrol` instead of raw fancontrol for better device handling.

