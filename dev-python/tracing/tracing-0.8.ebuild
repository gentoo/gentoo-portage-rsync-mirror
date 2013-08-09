# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tracing/tracing-0.8.ebuild,v 1.1 2013/08/09 15:19:42 mschiff Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
MY_P="python-${P}"

inherit distutils-r1

DESCRIPTION="Debug log/trace messages"
HOMEPAGE="http://liw.fi/tracing/"
SRC_URI="http://code.liw.fi/debian/pool/main/p/python-${PN}/python-${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	use doc && emake -C doc html
}

python_install_all() {
	dodoc README
	use doc && dohtml -r doc/_build/html/
	if use examples; then
		docompress -x usr/share/doc/${PF}/examples/
		insinto usr/share/doc/${PF}/examples/
		doins example.py
	fi
}
