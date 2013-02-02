# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/doit/doit-0.20.0.ebuild,v 1.1 2013/02/02 09:17:36 yngwin Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit eutils distutils-r1

DESCRIPTION="Automation tool"
HOMEPAGE="http://python-doit.sourceforge.net/ http://pypi.python.org/pypi/doit"
SRC_URI="mirror://pypi/${PN::1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyinotify"

src_install() {
	distutils-r1_src_install

	dodoc AUTHORS CHANGES README TODO.txt dev_requirements.txt
	dodoc -r doc
	docompress -x /usr/share/doc/${PF}/doc
}
