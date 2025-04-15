EAPI=8

DESCRIPTION="Port of OpenBSD's ksh(1)"
HOMEPAGE="https://github.com/RagnarokOS/oksh/"
SRC_URI="https://github.com/RagnarokOS/oksh/releases/download/${PV}/${PF}.tgz"

LICENSE="public-domain ISC"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	sys-libs/ncurses
"
RDEPEND="
	${DEPEND}
	!app-shells/ksh
	!app-shells/loksh
"

pkg_postinst() {
	add-shell /bin/ksh
	elog "Added ksh to /etc/shells..."
	elog "Don't forget to change your default shell using chsh."
}
