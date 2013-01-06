# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-filter/procmail-lib/procmail-lib-20081108.ebuild,v 1.7 2012/04/23 17:36:29 mgorny Exp $

MY_PV="2008.1108"

DESCRIPTION="Procmail Module Library is a collection of modules for Procmail"
HOMEPAGE="http://freshmeat.net/projects/procmail-lib"
SRC_URI="mirror://nongnu/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=""
RDEPEND="mail-filter/procmail"

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	emake DESTDIR="${D}" prefix=/usr install || die "make install failed"
	mv "${D}"/usr/share/doc/"${PN}" "${D}"/usr/share/doc/"${PF}"
}
