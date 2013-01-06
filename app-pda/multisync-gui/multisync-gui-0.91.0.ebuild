# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/multisync-gui/multisync-gui-0.91.0.ebuild,v 1.7 2012/05/03 20:20:59 jdhore Exp $

EAPI=1
inherit toolchain-funcs

DESCRIPTION="OpenSync multisync-gui"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="evo"

RDEPEND="<=app-pda/libopensync-0.35
	evo? ( >=app-pda/libopensync-plugin-evolution2-0.20 )
	>=gnome-base/libgnomeui-2
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_compile(){
	CPPFLAGS="${CXXFLAGS}" CFLAGS="${CXXFLAGS}" ./configure --prefix=/usr
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
}
