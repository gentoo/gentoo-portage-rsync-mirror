# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/flrig/flrig-1.3.10.ebuild,v 1.3 2013/02/08 21:41:49 ago Exp $

EAPI=2

DESCRIPTION="Transceiver control program for Amateur Radio use"
HOMEPAGE="http://www.w1hkj.com/flrig-help/index.html"
SRC_URI="http://www.w1hkj.com/downloads/flrig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND="x11-libs/libX11
	x11-libs/fltk:1
	x11-misc/xdg-utils"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README || die
}
