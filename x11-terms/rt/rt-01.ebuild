# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop savedconfig toolchain-funcs

DESCRIPTION="Simple terminal implementation for X"
HOMEPAGE="https://github.com/RagnarokOS/rt"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RagnarokOS/rt.git"
else
	SRC_URI="https://github.com/RagnarokOS/rt/releases/download/${PVR}/${PF}.tgz"
	KEYWORDS="amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	~x11-terms/rt-terminfo-${PVR}
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^STLDFLAGS/s|= .*|= $(LDFLAGS) $(LIBS)|g' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
	sed -i \
		-e '/tic/d' \
		Makefile || die

	restore_config config.h
}

src_configure() {
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die

	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc TODO

	make_desktop_entry ${PN} ragnarokterm utilities-terminal 'System;TerminalEmulator;' ''

	save_config config.h
}

pkg_postinst() {
	if [[ -z "${REPLACING_VERSIONS}" ]]; then
		elog "Please ensure a usable font is installed, like"
		elog "    media-fonts/corefonts"
		elog "    media-fonts/dejavu"
		elog "    media-fonts/urw-fonts"
	fi
}
