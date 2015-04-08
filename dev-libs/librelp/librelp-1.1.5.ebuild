# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librelp/librelp-1.1.5.ebuild,v 1.3 2014/08/10 20:37:44 slyfox Exp $

EAPI="5"

DESCRIPTION="An easy to use library for the RELP protocol"
HOMEPAGE="http://www.librelp.com/"
SRC_URI="http://download.rsyslog.com/${PN}/${P}.tar.gz"
LICENSE="GPL-3 doc? ( FDL-1.3 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~sparc ~x86"
IUSE="debug doc"

DEPEND=""
RDEPEND=">=net-libs/gnutls-2.12.23-r1"

src_configure() {
	econf \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
	use doc && dohtml doc/relp.html
}
