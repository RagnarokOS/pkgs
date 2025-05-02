# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR="JKEENAN"
DIST_VERSION=0.55
inherit perl-module

DESCRIPTION="Compare elements of two or more lists"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="
		virtual/perl-Carp
"
DEPEND="
		${RDEPEND}
		test? (
				virtual/perl-Test-Simple
		)
"
