# Copyright 2022-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Terminfo for x11-terms/rt"
HOMEPAGE="https://github.com/RagnarokOS/rt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RagnarokOS/rt.git"
else
	SRC_URI="https://github.com/RagnarokOS/rt/releases/download/${PVR}/rt-${PVR}.tgz"
	S="${WORKDIR}/rt-${PVR}"
	KEYWORDS="amd64"
fi

LICENSE="MIT"
SLOT="0"

BDEPEND=">=sys-libs/ncurses-6.0"

RESTRICT="test"

src_prepare() {
	mkdir -v terminfo || die "Failed to create terminfo directory"
	default
}

src_configure() {
	:
}

src_compile() {
	tic -sxo terminfo rt.info || die "Failed to translate terminfo file"
}

src_install() {
	insinto "/usr/share/rt"
	doins -r terminfo

	newenvd - "51${PN}" <<-_EOF_
		TERMINFO_DIRS="/usr/share/rt/terminfo"
		COLON_SEPARATED="TERMINFO_DIRS"
	_EOF_
}

pkg_postinst() {
	ewarn "Please run env-update and then source /etc/profile in any open shells"
	ewarn "to update terminfo settings. Relogin to update it for any new shells."
}
