# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-irclib/python-irclib-0.4.8.ebuild,v 1.3 2012/10/13 20:56:19 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="http://python-irclib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="ircbot.py irclib.py"

src_install() {
	distutils_src_install

	if use doc; then
		# Examples are treated like real documentation
		insinto "/usr/share/doc/${PF}/examples"
		doins dccreceive dccsend irccat irccat2 servermap testbot.py
	fi
}
