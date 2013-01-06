# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/linux-gazette/linux-gazette-182.ebuild,v 1.3 2011/03/13 21:18:07 vapier Exp $

DESCRIPTION="Sharing ideas and discoveries and Making Linux just a little more fun"
HOMEPAGE="http://linuxgazette.net/"
SRC_URI="http://linuxgazette.net/ftpfiles/lg-${PV}.tar.gz"

LICENSE="OPL"
SLOT="${PV}"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=app-doc/linux-gazette-base-${PV}"

S=${WORKDIR}

src_install() {
	dodir /usr/share/doc
	mv "${S}" "${D}"/usr/share/doc/${PN} || die
}
