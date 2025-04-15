EAPI=8

DESCRIPTION="Minimal package that provides only libcups.so.2"
HOMEPAGE="https://github.com/OpenPrinting/cups"
SRC_URI="https://github.com/IanLeCorbeau/pkgs/releases/download/${PVR}/${PF}.tgz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64"

# the libcups library comes from net-print/cups, it's already stripped
# so don't strip it again.
RESTRICT="strip"

S="${WORKDIR}/${PF}"

RDEPEND="
	!net-print/cups
"

src_install() {
	insinto /usr/lib64/
		dolib.so libcups.so.2

	dosym -r /usr/lib64/libcups.so.2 /usr/lib64/libcups.so

	dodoc README
}
