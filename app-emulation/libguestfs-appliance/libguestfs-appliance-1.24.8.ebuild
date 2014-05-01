# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libguestfs-appliance/libguestfs-appliance-1.24.8.ebuild,v 1.1 2014/05/01 19:57:02 maksbotan Exp $

EAPI=5

CHECKREQS_DISK_USR=500M
CHECKREQS_DISK_BUILD=500M

inherit check-reqs

DESCRIPTION="VM appliance disk image used in libguestfs package"
HOMEPAGE="http://libguestfs.org/"
SRC_URI="http://libguestfs.org/download/binaries/appliance/appliance-${PV}.tar.xz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/guestfs/
	doins -r appliance/

	newenvd "${FILESDIR}"/env.file 99"${PN}"
}
