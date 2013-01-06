# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxsadmin/nxsadmin-0.2.1.ebuild,v 1.2 2011/03/29 06:18:17 nirbheek Exp $

EAPI="1"

inherit autotools

DESCRIPTION="graphical tool for management of active NX sessions on FreeNX server"
HOMEPAGE="http://developer.berlios.de/projects/nxsadmin/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-cpp/gtkmm:2.4
	dev-util/intltool"
RDEPEND="dev-cpp/gtkmm:2.4
	net-misc/nxserver-freenx"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Needs to be regenerated
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "installation failed"
}
