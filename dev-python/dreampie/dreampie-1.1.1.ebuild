# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/dreampie/dreampie-1.1.1.ebuild,v 1.1 2011/09/10 10:42:25 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="pygtk-based python shell"
HOMEPAGE="http://dreampie.sourceforge.net/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygtk
	dev-python/pygtksourceview"
DEPEND=""

src_prepare() {
	python_convert_shebangs 2 ${PN}
}
