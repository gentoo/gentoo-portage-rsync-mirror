# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycxx/pycxx-6.2.4-r1.ebuild,v 1.4 2012/06/08 11:34:54 phajdan.jr Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit eutils distutils

DESCRIPTION="Set of facilities to extend Python with C++"
HOMEPAGE="http://cxx.sourceforge.net"
SRC_URI="mirror://sourceforge/cxx/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-solaris"
IUSE="doc examples"

PYTHON_MODNAME="CXX"

src_prepare() {
	epatch "${FILESDIR}/${PN}-6.2.3-python-3.patch"
	epatch "${FILESDIR}/${PN}-6.2.3-installation.patch"

	# Without this, pysvn fails.
	# CXX/Python2/Config.hxx: No such file or directory
	sed -e "/^#include/s:/Python[23]/:/:" -i CXX/*/*.hxx || die "sed failed"
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r Doc/ || die "dohtml failed"
	fi

	if use examples; then
		docinto examples/python-2
		dodoc Demo/Python2/* || die "dodoc failed"
		docinto examples/python-3
		dodoc Demo/Python3/* || die "dodoc failed"
	fi
}
