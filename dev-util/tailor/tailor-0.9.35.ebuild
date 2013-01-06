# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tailor/tailor-0.9.35.ebuild,v 1.4 2012/02/16 13:10:33 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A tool to migrate changesets between version control systems."
HOMEPAGE="http://wiki.darcs.net/index.html/Tailor"
SRC_URI="http://darcs.arstecnica.it/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="vcpx"

src_install() {
	dohtml README.html
	distutils_src_install
	rm "${D}usr/share/doc/${PF}/README.html"
}

pkg_postinst() {
	distutils_pkg_postinst
	elog "Tailor does not explicitly depend on any other VCS."
	elog "You should emerge whatever VCS(s) that you want to use seperately."
}
