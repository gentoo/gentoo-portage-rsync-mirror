# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/grsync/grsync-1.2.1.ebuild,v 1.2 2012/05/05 04:53:41 jdhore Exp $

EAPI=4
inherit gnome2

DESCRIPTION="A gtk frontend to rsync"
HOMEPAGE="http://www.opbyte.it/grsync/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""
SRC_URI="http://www.opbyte.it/release/${P}.tar.gz"

RDEPEND=">=x11-libs/gtk+-2.16:2
	net-misc/rsync"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS NEWS README"

src_configure() {
	econf --disable-unity
}
