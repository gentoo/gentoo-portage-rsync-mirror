# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xesam-tools/xesam-tools-0.7.0.ebuild,v 1.4 2011/10/24 05:44:03 tetromino Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_USE_WITH="xml"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Development tools and examples for the Xesam desktop search API"
HOMEPAGE="http://xesam.org/people/kamstrup/xesam-tools"
SRC_URI="http://xesam.org/people/kamstrup/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="examples"

DEPEND=""
RDEPEND="dev-python/dbus-python
	dev-python/pygobject:2
	dev-python/pygtk"

PYTHON_MODNAME="xesam"

src_install() {
	distutils_src_install

	insinto "/usr/share/doc/${PF}"
	doins -r samples

	if use examples; then
		insinto "/usr/share/doc/${PF}/demo"
		doins "demo/demo.py"
		insopts -m 0755
		doins demo/[^d]*
	fi
}
