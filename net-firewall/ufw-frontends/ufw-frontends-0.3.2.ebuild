# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ufw-frontends/ufw-frontends-0.3.2.ebuild,v 1.2 2013/02/07 22:30:58 ulm Exp $

EAPI=4
PYTHON_DEPEND="2:2.6"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.5 3.* *-jython"
inherit distutils

DESCRIPTION="Provides graphical frontend to ufw"
HOMEPAGE="http://code.google.com/p/ufw-frontends/"
SRC_URI="http://ufw-frontends.googlecode.com/files/${P}.tar.gz"

# CC* is for a png file
LICENSE="GPL-3 CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pygobject:2
	dev-python/pygtk
	dev-python/pyinotify
	net-firewall/ufw
	x11-libs/gksu"

src_prepare() {
	sed -i 's/^Exec=su-to-root -X -c/Exec=gksu/' \
		share/ufw-gtk.desktop || die
	# Qt version is unusable for now
	rm gfw/frontend_qt.py || die
	distutils_src_prepare
}
