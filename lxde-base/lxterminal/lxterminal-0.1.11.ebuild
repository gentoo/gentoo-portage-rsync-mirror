# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxterminal/lxterminal-0.1.11.ebuild,v 1.6 2012/06/05 00:38:01 xmw Exp $

EAPI="4"

DESCRIPTION="Lightweight vte-based tabbed terminal emulator for LXDE"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha amd64 arm ~mips ppc x86 ~x86-interix ~amd64-linux ~x86-linux"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	dev-libs/glib:2
	x11-libs/vte:0"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40.0"

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS README
}
