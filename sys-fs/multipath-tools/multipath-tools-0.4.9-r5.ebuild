# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/multipath-tools-0.4.9-r5.ebuild,v 1.11 2013/04/09 10:12:33 ssuominen Exp $

EAPI=4
inherit base eutils toolchain-funcs udev

DESCRIPTION="Device mapper target autoconfig"
HOMEPAGE="http://christophe.varoqui.free.fr/"
SRC_URI="http://christophe.varoqui.free.fr/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND=">=sys-fs/lvm2-2.02.45
	>=virtual/udev-171
	dev-libs/libaio
	sys-libs/readline
	!<sys-apps/baselayout-2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}

PATCHES=(
	"${FILESDIR}"/${PN}-0.4.9-build.patch
	"${FILESDIR}"/${PN}-0.4.9-buffer-overflows.patch
	"${FILESDIR}"/${PN}-0.4.8-kparted-ext-partitions.patch
	"${FILESDIR}"/${PN}-0.4.9-log_enquery_overflow.patch
)

src_compile() {
	# LIBDM_API_FLUSH involves grepping files in /usr/include,
	# so force the test to go the way we want #411337.
	emake LIBDM_API_FLUSH=1 CC="$(tc-getCC)"
}

src_install() {
	local udevdir="$(udev_get_udevdir)"

	dodir /sbin /usr/share/man/man8
	emake \
		DESTDIR="${D}" \
		libudevdir='${prefix}'/"${udevdir}" \
		install

	insinto /etc
	newins "${S}"/multipath.conf.annotated multipath.conf
	# drop this one it doesnt work with recent udev bug #413063
	rm "${D}"/etc/udev/rules.d/65-multipath.rules || die
	# /etc/udev is reserved for user modified rules!
	mv "${D}"/etc/udev/rules.d "${D}/${udevdir}"/ || die
	fperms 644 "${udevdir}"/rules.d/66-kpartx.rules
	newinitd "${FILESDIR}"/rc-multipathd multipathd
	newinitd "${FILESDIR}"/multipath.rc multipath

	dodoc multipath.conf.* AUTHOR ChangeLog FAQ README TODO
	docinto kpartx
	dodoc kpartx/ChangeLog kpartx/README
}

pkg_preinst() {
	# The dev.d script was previously wrong and is now removed (the udev rules
	# file does the job instead), but it won't be removed from live systems due
	# to cfgprotect.
	# This should help out a little...
	if [[ -e ${ROOT}/etc/dev.d/block/multipath.dev ]] ; then
		mkdir -p "${D}"/etc/dev.d/block
		echo "# Please delete this file. It is obsoleted by /etc/udev/rules.d/65-multipath.rules" \
			> "${D}"/etc/dev.d/block/multipath.dev
	fi
}

pkg_postinst() {
	elog "If you need multipath on your system, you must"
	elog "add 'multipath' into your boot runlevel!"
}
