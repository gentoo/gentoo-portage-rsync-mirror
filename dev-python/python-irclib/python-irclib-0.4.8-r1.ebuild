# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-irclib/python-irclib-0.4.8-r1.ebuild,v 1.2 2013/09/05 18:46:20 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy2_0 )

inherit distutils-r1

DESCRIPTION="IRC client framework written in Python."
HOMEPAGE="http://python-irclib.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

python_install_all() {
	if use doc; then
		# Examples are treated like real documentation
		insinto "/usr/share/doc/${PF}/examples"
		doins dccreceive dccsend irccat irccat2 servermap testbot.py
	fi
	distutils-r1_python_install_all
}
