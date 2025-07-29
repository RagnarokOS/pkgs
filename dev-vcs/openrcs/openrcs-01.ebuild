EAPI=8

DESCRIPTION="Port of OpenBSD's RCS"
HOMEPAGE="https://github.com/RagnarokOS/openrcs/"
SRC_URI="https://github.com/RagnarokOS/openrcs/releases/download/${PVR}/${PF}.tgz"

LICENSE="public-domain ISC BSD"
SLOT="0"
KEYWORDS="amd64"

BDEPEND="dev-libs/libopenbsd
		dev-util/oyacc"
DEPEND="${DEPEND}"
RDEPEND="
	${DEPEND}
	!dev-vcs/rcs
"
