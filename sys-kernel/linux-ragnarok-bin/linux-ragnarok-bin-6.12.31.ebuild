# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Pre-built version of Ragnarok's Linux kernel build"
HOMEPAGE="https://github.com/RagnarokOS/kernel-build"
SRC_URI="https://github.com/RagnarokOS/kernel-build/releases/download/${PVR}/linux-${PVR}-ragnarok.tgz"

S=${WORKDIR}

SLOT="0"
KEYWORDS="amd64"

# Do not strip, this removes the modules signatures.
RESTRICT="strip"

# Fetch gentoo-sources first.
DEPEND="~sys-kernel/gentoo-sources-${PVR}"
RDEPEND="${DEPEND}"
BDEPEND="
		app-alternatives/bc
		sys-devel/flex
		virtual/libelf
		app-alternatives/yacc
"

QA_PREBUILT="*"

src_prepare() {
	# die if /boot isn't mounted.
	if ! /usr/bin/mount | grep -q /boot; then
		die "/boot needs to be mounted."
	fi
	eapply_user
}

src_install() (
	declare MODULES_TARGET=/usr
	declare SRC_DIR=/usr/src/linux-${PVR}-gentoo

	dodir ${MODULES_TARGET}

	insinto ${MODULES_TARGET}
		doins -r lib

	insinto /
		doins -r boot

	# Put Ragnarok's config in Gentoo's kernel source dir.
	insinto ${SRC_DIR}
		newins boot/config-${PVR}-ragnarok .config
)

pkg_preinst() {
	# Move old symlinks.
	(cd /boot && for _f in config System.map vmlinuz; do mv ${_f} ${_f}.old; done)
}

pkg_postinst() {
	elog "The Ragnarok kernel has been installed."
	elog "Don't forget to generate a new initramfs with"
	elog "the 'dracut --kver=${PVR}-ragnarok' command"
	elog "and update your grub configuration with the"
	elog "'grub-mkconfig -o /boot/grub/grub.cfg' command."
}
