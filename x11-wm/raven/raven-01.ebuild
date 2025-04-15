EAPI=8

inherit savedconfig toolchain-funcs

DESCRIPTION="a dynamic window manager for X11"
HOMEPAGE="https://github.com/RagnarokOS/raven"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/RagnarokOS/raven.git"
else
	SRC_URI="https://github.com/RagnarokOS/raven/releases/download/${PVR}/${PF}.tgz"
	KEYWORDS="amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="xinerama"

RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	>=x11-libs/libXft-2.3.5
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="
	${RDEPEND}
	x11-base/xorg-proto
	xinerama? ( x11-base/xorg-proto )
"

src_prepare() {
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die

	restore_config config.h
}

src_compile() {
	if use xinerama; then
		emake CC="$(tc-getCC)" raven
	else
		emake CC="$(tc-getCC)" XINERAMAFLAGS="" XINERAMALIBS="" raven
	fi
}

src_install() {
	emake DESTDIR="${D}" install

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/raven-session2 raven

	insinto /usr/share/xsessions
	doins "${FILESDIR}"/raven.desktop

	dodoc README.md

	save_config config.h
}
