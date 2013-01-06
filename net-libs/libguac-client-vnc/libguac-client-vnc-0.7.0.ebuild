# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libguac-client-vnc/libguac-client-vnc-0.7.0.ebuild,v 1.2 2012/12/05 20:51:31 nativemad Exp $

EAPI=4

inherit eutils
DESCRIPTION="This is the vnc-client-library used by www-apps/guacamole."

HOMEPAGE="http://guacamole.sourceforge.net/"
SRC_URI="mirror://sourceforge/guacamole/${P}.tar.gz"

LICENSE="AGPL-3"

SLOT="0"

KEYWORDS="~x86"

IUSE=""
DEPEND="net-libs/libguac
	net-libs/libvncserver"
RDEPEND="${DEPEND}"
src_configure() {
	econf
}

src_compile() {
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
}
