#!/usr/bin/env bash
# =============================================
# Day 002 : Temporary User Setup with Expiry
# Date: 2026-08-02
# =============================================

# --- Goal ---
# Create a user that stops working by itself on a given date,
# for a contractor or a temporary access.

# --- What I did ---

# 1. Connect to the app server and become root
ssh banner@stapp03
sudo su -

# ssh asks for banner's password, then sudo su - opens a root shell
# so I do not have to prefix every command with sudo.

# 2. Create the user with the expiry date already set
useradd -e 2027-03-28 anita
# or
useradd anita
chage -E 2027-03-28 anita

# -e on useradd sets the date at creation time.
# -E on chage sets or changes it on a user that already exists.
# The format is always YYYY-MM-DD.

# 3. Check the result
chage -l anita
# Account expires : Mar 28, 2027

# --- Problem I hit ---
# -e is lowercase on useradd but uppercase -E on chage, easy to mix up.
#
# I was logged in as anita over ssh, then set the expiry from another
# terminal as root. The open session kept working, nothing happened.
# The date is only checked when a new session opens: after exit, the
# next ssh attempt was refused because the account had expired.

# --- What I learned ---
# The expiry date lives in the 8th field of /etc/shadow, stored as a
# number of days since 1970. chage -l reads it back in a human format.
# On that date the account is locked, the user simply cannot log in,
# nothing is deleted. Confirmed with:
grep anita /etc/shadow
