# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-evolution2/libopensync-plugin-evolution2-0.22.ebuild,v 1.3 2008/11/15 09:37:07 mescalinum Exp $

DESCRIPTION="OpenSync Evolution 2 Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.bz2"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="=app-pda/libopensync-${PV}*
	gnome-extra/evolution-data-server"
RDEPEND="${DEPEND}"

# interactive and broken
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^AM_CFLAGS/s/-Werror//g' src/Makefile.{am,in}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
