EAPI=8

DESCRIPTION="Port of OpenBSD's ed(1)"
HOMEPAGE="https://github.com/RagnarokOS/ed/"
SRC_URI="https://github.com/RagnarokOS/ed/releases/download/${PVR}/ed-${PVR}.tgz"

S="${WORKDIR}/ed-${PVR}"

LICENSE="public-domain ISC BSD-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	!sys-apps/ed
"

