# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/whaw/whaw-0.1.2.ebuild,v 1.1 2009/07/19 17:23:00 wired Exp $

EAPI="2"

DESCRIPTION="Window manager independent Window Layout tool"
HOMEPAGE="http://repetae.net/computer/whaw/"
SRC_URI="http://repetae.net/computer/${PN}/drop/whaw-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

src_install() {
	emake INSTALL_ROOT="${D}" DESTDIR="${D}" install || die "emake install failed"
}
