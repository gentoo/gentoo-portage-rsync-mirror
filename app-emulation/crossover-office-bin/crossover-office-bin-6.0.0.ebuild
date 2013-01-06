# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/crossover-office-bin/crossover-office-bin-6.0.0.ebuild,v 1.6 2012/05/10 02:13:15 tetromino Exp $

inherit unpacker

DESCRIPTION="simplified/streamlined version of wine with commercial support"
HOMEPAGE="http://www.codeweavers.com/products/cxoffice/"
SRC_URI="install-crossover-standard-${PV}.sh"

LICENSE="CROSSOVER"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="nas"
RESTRICT="fetch strip"

RDEPEND="sys-libs/glibc
	x11-libs/libXrandr
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	dev-util/desktop-file-utils
	nas? ( media-libs/nas )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	einfo "and place ${A} in ${DISTDIR}"
}

src_unpack() {
	unpack_makeself # needed due to .sh extension; #415013
}

src_install() {
	dodir /opt/cxoffice
	cp -r * "${D}"/opt/cxoffice || die "cp failed"
	rm -r "${D}"/opt/cxoffice/setup.{sh,data}
	insinto /opt/cxoffice/etc
	doins support/templates/cxoffice.conf
}

pkg_postinst() {
	einfo "Run /opt/cxoffice/bin/cxsetup as normal user to create"
	einfo "bottles and install Windows applications."
}
