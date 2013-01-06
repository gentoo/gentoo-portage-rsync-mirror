# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/cbrpager/cbrpager-0.9.22.ebuild,v 1.3 2012/05/21 19:57:57 ssuominen Exp $

EAPI=3

inherit eutils base

DESCRIPTION="a simple comic book pager."
HOMEPAGE="http://cbrpager.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="|| ( app-arch/unrar app-arch/rar )
	>=gnome-base/libgnomeui-2"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig"

src_install() {
	base_src_install
	dodoc AUTHORS ChangeLog CONTRIBUTORS NEWS README TODO || die
	make_desktop_entry ${PN} "CBR Pager" ${PN} "Graphics;Viewer;Amusement;GTK"
}
