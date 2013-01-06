# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/edac-utils/edac-utils-0.12.ebuild,v 1.1 2008/04/09 20:53:08 dev-zero Exp $

DESCRIPTION="Userspace helper for Linux kernel EDAC drivers"
HOMEPAGE="http://sourceforge.net/projects/edac-utils/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="sys-fs/sysfsutils"
RDEPEND="${DEPEND}
	sys-apps/dmidecode"

src_compile() {
	econf $(use_enable debug)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog DISCLAIMER META NEWS README TODO

	# We don't need this init.d file
	# Modules should be loaded by adding them to /etc/conf.d/modules
	# The rest is done via the udev-rule
	rm "${D}/etc/init.d/edac"
}

pkg_postinst() {
	elog "There must be an entry for your mainboard in /etc/edac/labels.db"
	elog "in case you want nice labels in /sys/module/*_edac/"
	elog "Run the following command to check whether such an entry is already available:"
	elog "    edac-ctl --print-labels"
}
