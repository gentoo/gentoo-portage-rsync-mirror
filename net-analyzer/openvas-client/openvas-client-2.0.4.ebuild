# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/openvas-client/openvas-client-2.0.4.ebuild,v 1.3 2011/03/29 12:47:23 angelos Exp $

EAPI=1
inherit eutils

DESCRIPTION="A client for the openvas vulnerability scanner"
HOMEPAGE="http://www.openvas.org/"
SRC_URI="http://wald.intevation.org/frs/download.php/595/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

DEPEND="net-libs/gnutls
	gtk? ( >=x11-libs/gtk+-2.8.8:2 )"
RDEPEND="${DEPEND}"

# Upstream bug:
# http://wald.intevation.org/tracker/index.php?func=detail&aid=941&group_id=29&atid=220
MAKEOPTS="-j1"

src_compile() {
	econf $(use_enable gtk) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS CHANGES README TODO || die "dodoc failed"

	make_desktop_entry OpenVAS-Client "OpenVAS Client"
}
