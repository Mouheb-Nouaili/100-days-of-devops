#!/usr/bin/env bash
# =============================================
# Day 001 : Linux User Setup with Non-Interactive Shell
# Date: 2026-08-02
# =============================================

# --- Goal ---
# Create a user that can exist on the system but cannot log in.

# --- What I did ---

# 1. Create the user with a non-interactive shell
sudo useradd -s /sbin/nologin siva
# or
sudo adduser --shell /sbin/nologin siva

# useradd is the base command, works on every distro.
# adduser is a friendlier wrapper, Debian/Ubuntu only, and it asks
# questions while it runs. On RHEL it is just a symlink to useradd.
# -s and --shell do the same thing: set the login shell.

# 2. Same result with /bin/false
sudo useradd -s /bin/false siva

# nologin refuses the login and prints "This account is currently
# not available." false just exits with no message at all.
# nologin is the usual pick for service accounts, the message tells
# you why the login failed.

# --- Problem I hit ---
# The path is /sbin/nologin on RHEL but /usr/sbin/nologin on Ubuntu.
# Found the right one with: cat /etc/shells

# --- What I learned ---
# The last field of /etc/passwd is the login shell, that is what
# decides if a session can open. Checked my work with:
grep siva /etc/passwd
