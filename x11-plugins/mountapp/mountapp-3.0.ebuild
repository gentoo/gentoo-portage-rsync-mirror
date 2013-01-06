# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/mountapp/mountapp-3.0.ebuild,v 1.13 2012/07/04 10:06:52 voyageur Exp $

DESCRIPTION="mount filesystems via an easy-to-use windowmaker applet"
HOMEPAGE="http://mountapp.sourceforge.net"
SRC_URI="http://mountapp.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	=x11-libs/gtk+-1.2*
	x11-libs/libX11
	>=x11-libs/libXpm-3.5.7
	<x11-wm/windowmaker-0.95"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xproto"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO || die
}
