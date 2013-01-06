# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/doit/doit-0.16.1.ebuild,v 1.2 2012/08/29 10:22:38 marienz Exp $

EAPI=4
PYTHON_COMPAT="python2_6 python2_7 python3_2"

inherit eutils python-distutils-ng

DESCRIPTION="Automation tool"
HOMEPAGE="http://python-doit.sourceforge.net/ http://pypi.python.org/pypi/doit"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyinotify"

src_prepare() {
	epatch "${FILESDIR}/doit-0.16.1-setup.py-encoding.patch"

	python-distutils-ng_src_prepare
}

src_install() {
	python-distutils-ng_src_install

	dodoc AUTHORS CHANGES README TODO.txt
	dodoc -r doc
	docompress -x /usr/share/doc/${PF}/doc
}
