# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit savedconfig toolchain-funcs

DESCRIPTION="Ragnarok's build of Suckless' dmenu."
HOMEPAGE="https://github.com/RagnarokOS/dmenu/"
SRC_URI="https://github.com/RagnarokOS/dmenu/releases/download/${PVR}/${PF}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="xinerama"

RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	>=x11-libs/libXft-2.3.5
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"

src_prepare() {
	default

	restore_config config.h
}

src_compile() {
	if use xinerama; then
		emake CC="$(tc-getCC)"
	else
		emake CC="$(tc-getCC)" XINERAMAFLAGS="" XINERAMALIBS=""
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install

	save_config config.h
}
