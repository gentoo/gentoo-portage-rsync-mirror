# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dissy/dissy-10.ebuild,v 1.3 2011/10/24 05:42:57 tetromino Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit distutils

DESCRIPTION="A graphical frontend to the objdump disassembler"
HOMEPAGE="http://code.google.com/p/dissy/"
SRC_URI="http://dissy.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="sys-devel/binutils
	dev-python/pygtk
	dev-python/pygobject:2
	dev-python/pywebkitgtk"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e "/('share\/doc\//"d setup.py || die "sed failed"
	distutils_src_prepare
}
