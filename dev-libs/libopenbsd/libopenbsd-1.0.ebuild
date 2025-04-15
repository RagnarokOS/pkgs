EAPI=8

DESCRIPTION="Small lib containing OpenBSD-specific functions"
HOMEPAGE="https://github.com/RagnarokOS/libopenbsd/"
SRC_URI="https://github.com/RagnarokOS/libopenbsd/releases/download/${PVR}/${PF}.tgz"

LICENSE="public-domain ISC"
SLOT="0"
KEYWORDS="amd64"

# Don't strip it.
RESTRICT="strip"

DEPEND="
	sys-libs/glibc
"
