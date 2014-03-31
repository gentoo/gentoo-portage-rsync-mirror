# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twill/twill-0.9-r1.ebuild,v 1.3 2014/03/31 21:18:11 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} pypy pypy2_0 )

inherit distutils-r1

MY_PV="${PV/_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Simple scripting language for web browsing with Python API."
HOMEPAGE="http://twill.idyll.org/"
SRC_URI="http://darcs.idyll.org/~t/projects/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${MY_P}"

python_install_all() {
	dodoc -r doc/.
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/*
	docompress -x /usr/share/doc/${PF}/examples
}
