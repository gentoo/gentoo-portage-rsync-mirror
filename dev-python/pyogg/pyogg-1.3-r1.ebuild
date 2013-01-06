# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyogg/pyogg-1.3-r1.ebuild,v 1.18 2012/02/24 00:57:27 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit distutils toolchain-funcs

DESCRIPTION="Python bindings for the ogg library"
HOMEPAGE="http://www.andrewchatham.com/pyogg/"
# Grumble. They changed the tarball without changing the name..
#SRC_URI="http://www.andrewchatham.com/pyogg/download/${P}.tar.gz"
SRC_URI="mirror://gentoo/${P}-r1.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=media-libs/libogg-1.0"
RDEPEND="${DEPEND}"

DOCS="COPYING ChangeLog"
PYTHON_MODNAME="ogg"

src_configure() {
	CC=$(tc-getCC) "$(PYTHON -f)" config_unix.py || die "Configuration failed"
}

src_install() {
	distutils_src_install
	insinto /usr/share/doc/${PF}/examples
	doins test/*
}
