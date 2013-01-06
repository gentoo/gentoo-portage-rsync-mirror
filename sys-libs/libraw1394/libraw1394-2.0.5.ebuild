# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libraw1394/libraw1394-2.0.5.ebuild,v 1.2 2010/02/25 21:22:29 ssuominen Exp $

EAPI=2

DESCRIPTION="library that provides direct access to the IEEE 1394 bus"
HOMEPAGE="http://ieee1394.wiki.kernel.org/"
SRC_URI="mirror://kernel/linux/libs/ieee1394/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="!<media-libs/libdc1394-1.2.2"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--without-fw-dir
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
