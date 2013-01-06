# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-2.0.4.ebuild,v 1.7 2010/04/16 09:54:55 pacho Exp $

DESCRIPTION="library that provides direct access to the IEEE 1394 bus"
HOMEPAGE="http://www.linux1394.org/"
SRC_URI="http://www.linux1394.org/dl/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="!<media-libs/libdc1394-1.2.2"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
