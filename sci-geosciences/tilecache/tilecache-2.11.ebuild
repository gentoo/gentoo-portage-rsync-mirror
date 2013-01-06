# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/tilecache/tilecache-2.11.ebuild,v 1.1 2011/06/01 09:53:25 scarabeus Exp $

EAPI=3

PYTHON_DEPEND="2"
inherit distutils

DESCRIPTION="Web map tile caching system"
HOMEPAGE="http://tilecache.org/"
SRC_URI="http://${PN}.org/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/imaging
	dev-python/paste"
DEPEND="${RDEPEND}
	dev-python/setuptools
"

pkg_setup() {
	python_set_active_version 2
}

src_install() {
	distutils_src_install "--debian"
}
