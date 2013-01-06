# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/multipath-tools/multipath-tools-0.4.8-r1.ebuild,v 1.8 2012/12/11 10:07:21 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Device mapper target autoconfig"
HOMEPAGE="http://christophe.varoqui.free.fr/"
SRC_URI="http://christophe.varoqui.free.fr/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE=""

RDEPEND="|| (
		>=sys-fs/lvm2-2.02.45
		>=sys-fs/device-mapper-1.00.19-r1
	)
	virtual/udev
	dev-libs/libaio"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.4.8-build.patch
	epatch "${FILESDIR}"/${PN}-0.4.8-udev-scsi_id-changes.patch
	# Patch per upstream tree for 1GiB limit of kpartx
	epatch "${FILESDIR}"/${PN}-0.4.8-r1-kpartx.patch
	# CVE-2009-0115, world writable socket
	epatch "${FILESDIR}"/${PN}-0.4.8-socket-cve-2009-0115.patch
}

src_compile() {
	# The -j1 is NOT a joke. The 0.4.8-era upstream code rebuilds several object
	# files with different compiler defines. The upstream git, as yet unreleased
	# moves to proper automake, but it's a large jump and is not being
	# backported to 0.4.8.
	emake -j1 CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dodir /sbin /usr/share/man/man8
	make DESTDIR="${D}" install || die "install failed"

	insinto /etc
	newins "${S}"/multipath.conf.annotated multipath.conf
	fperms 644 /etc/udev/rules.d/65-multipath.rules
	fperms 644 /etc/udev/rules.d/66-kpartx.rules
	# This is the monitoring daemon
	newinitd "${FILESDIR}"/rc-multipathd multipathd
	# This is the init script that fires the multipath addon for baselayout2
	newinitd "${FILESDIR}"/init.d-multipath-0.4.8-r1 multipath
	# Handle early-boot startup as well as shutdown of multipath devices
	insinto /lib/rcscripts/addons
	doins "${FILESDIR}"/multipath-start.sh
	doins "${FILESDIR}"/multipath-stop.sh

	dodoc multipath.conf.*
	dodoc AUTHOR ChangeLog FAQ README TODO
	docinto kpartx; dodoc kpartx/ChangeLog kpartx/README
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
	elog "If you need multipath on your system, you should ensure that a"
	elog "'multipath' entry is present in your RC_VOLUME_ORDER variable!"
	elog "If you use baselayout2, you must add 'multipath' into"
	elog "your boot runlevel!"
}
