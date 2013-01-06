# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guacd/guacd-0.7.0.ebuild,v 1.1 2012/12/05 20:37:27 nativemad Exp $

EAPI=4

inherit eutils
DESCRIPTION="This is the proxy-daemon used by www-apps/guacamole."

HOMEPAGE="http://guacamole.sourceforge.net/"
SRC_URI="mirror://sourceforge/guacamole/${P}.tar.gz"

LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="net-libs/libguac"
RDEPEND="${DEPEND}"

src_configure() {
	econf
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	doinitd "${S}"/init.d/guacd
}
