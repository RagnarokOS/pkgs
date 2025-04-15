# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="user for the sysupdate command"
ACCT_USER_ID=999
ACCT_USER_GROUPS=( sysupdate )
ACCT_USER_HOME="/var/db/sysupdate"

acct-user_add_deps
