# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/telepathy-python/telepathy-python-0.15.17.ebuild,v 1.6 2010/08/07 16:50:34 armin76 Exp $

DESCRIPTION="Telepathy Python base classes for use in connection managers, and proxy classes for use in clients."
HOMEPAGE="http://telepathy.freedesktop.org/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE=""

DEPEND="dev-libs/libxslt"
RDEPEND=">=dev-python/dbus-python-0.80"

# bug #288191
MAKEOPTS="-j1"

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS
}
