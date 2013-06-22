# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pywebkitgtk/pywebkitgtk-1.1.8-r1.ebuild,v 1.1 2013/06/22 08:31:01 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1

DESCRIPTION="Python bindings for the WebKit GTK+ port"
HOMEPAGE="http://code.google.com/p/pywebkitgtk/"
SRC_URI="http://pywebkitgtk.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-libs/libxslt[${PYTHON_USEDEP}]
	>=net-libs/webkit-gtk-1.1.15:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( AUTHORS MAINTAINERS NEWS README )

python_configure_all() {
	python_configure_all --disable-static
}
