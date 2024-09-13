# Include basic GUI protections
include disable-common.inc
include disable-programs.inc
include disable-devel.inc
include disable-exec.inc
# include disable-interpreters.inc
include disable-shell.inc
include disable-write-mnt.inc
include disable-xdg.inc

# Persistent local customizations
include default.local

# Persistent global definitions
include globals.local

# include whitelist-common.inc
# include whitelist-runuser-common.inc
# include whitelist-usr-share-common.inc
# include whitelist-var-common.inc

# Whitelist directories
whitelist ${HOME}/share
whitelist ${HOME}/.config/pulse
whitelist /run/user/$UID/pulse
whitelist /run/user/$UID/pulse/native

# Drop all capabilities
caps.drop all

# Remove seccomp filtering
seccomp

# Enable or disable other features as needed
notv
nou2f
novideo
# apparmor
ipc-namespace
machine-id
net none
netfilter
# no3d
nodvd
nogroups
noinput
nonewprivs
noroot
# nosound

# Network restrictions
# protocol unix

shell none

# Tracing restrictions
tracelog

# disable-mnt

# Memory protection
memory-deny-write-execute

# see /usr/share/doc/firejail/profile.template for more common private-etc paths.
# Private filesystem isolation
private-bin mpv
private-cache
private-dev
private-etc hosts,passwd,group,machine-id,alternatives,fonts
private-lib
private-opt none
private-tmp

dbus-user none
dbus-system none

# deterministic-shutdown

# Memory protection
memory-deny-write-execute

# Read-only home directory
read-only ${HOME}

# Enforce namespace restrictions
restrict-namespaces