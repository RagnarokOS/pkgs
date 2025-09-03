# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Fork of OpenBSD's excellent Calm Window Manager (cwm)"
HOMEPAGE="https://github.com/IanLeCorbeau/CroWM"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/IanLeCorbeau/CroWM.git"
else
	SRC_URI="https://github.com/IanLeCorbeau/CroWM/releases/download/${PVR}/${PF}.tar.xz"
	KEYWORDS="amd64"
fi

LICENSE="ISC"
SLOT="0"

DEPEND="x11-libs/libX11
		x11-libs/libXft
		x11-libs/libXrandr"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/oyacc"

src_prepare() {
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
}

src_compile() {
	emake CC="$(tc-getCC)" YACC="/usr/bin/oyacc"
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README.md
}
