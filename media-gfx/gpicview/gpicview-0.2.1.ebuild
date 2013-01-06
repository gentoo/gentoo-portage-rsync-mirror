# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpicview/gpicview-0.2.1.ebuild,v 1.9 2012/05/05 07:00:20 jdhore Exp $

EAPI=2

DESCRIPTION="A Simple and Fast Image Viewer for X"
HOMEPAGE="http://lxde.sourceforge.net/gpicview"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ppc x86"
IUSE=""

RDEPEND="virtual/jpeg
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}
