EAPI=8

DESCRIPTION="Port of OpenBSD's ksh(1)"
HOMEPAGE="https://github.com/RagnarokOS/oksh/"
SRC_URI="https://github.com/RagnarokOS/oksh/releases/download/${PVR}/${PF}.tgz"

LICENSE="public-domain ISC"
SLOT="0"
KEYWORDS="amd64"

S="${WORKDIR}/${PF}"

DEPEND="
	sys-libs/ncurses
"
RDEPEND="
	${DEPEND}
	!app-shells/ksh
	!app-shells/loksh
"
