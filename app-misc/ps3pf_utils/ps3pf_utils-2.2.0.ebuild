# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ps3pf_utils/ps3pf_utils-2.2.0.ebuild,v 1.2 2010/01/01 18:34:26 ssuominen Exp $

inherit flag-o-matic

DESCRIPTION="Utilities to set the ps3 specific features"
HOMEPAGE="http://www.playstation.com/ps3-openplatform/index.html"
SRC_URI="mirror://gentoo/ps3-utils-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc -ppc64"
IUSE=""

# fixme: depend on a version of sys-kernel/linux-headers that supports ps3

S=${WORKDIR}/ps3-utils-${PV}

src_install() {
	emake DESTDIR="${D}" install || die
}
