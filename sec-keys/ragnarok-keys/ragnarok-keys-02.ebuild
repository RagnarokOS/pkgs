# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Public Signify and PGP keys for Ragnarok"
HOMEPAGE="https://github.com/RagnarokOS/src"
SRC_URI="https://github.com/RagnarokOS/src/releases/download/${PVR}/ragnarok-keys-${PVR}.tgz"

SLOT="${PV}"
KEYWORDS="amd64"

DEPEND="app-crypt/signify"
RDEPEND="${DEPEND}"

src_install() {
	insinto /etc/signify
	doins ragnarok*

	insinto /usr/share/openpgp-keys
	doins *.asc
}
