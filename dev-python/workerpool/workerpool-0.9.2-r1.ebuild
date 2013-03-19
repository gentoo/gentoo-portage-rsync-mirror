# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/workerpool/workerpool-0.9.2-r1.ebuild,v 1.1 2013/03/19 15:39:16 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_{5,6,7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Module for distributing jobs to a pool of worker threads."
HOMEPAGE="http://github.com/shazow/workerpool"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test examples"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools"

python_test() {
	nosetests -v test || die
}

python_install_all() {
	if use examples; then
		docompress -x usr/share/doc/${P}/samples
		insinto usr/share/doc/${P}/
		doins -r samples
	fi
}
