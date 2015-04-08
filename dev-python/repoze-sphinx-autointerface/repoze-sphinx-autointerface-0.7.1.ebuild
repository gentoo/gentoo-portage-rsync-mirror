# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/repoze-sphinx-autointerface/repoze-sphinx-autointerface-0.7.1.ebuild,v 1.3 2014/12/12 23:23:21 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} )

inherit distutils-r1

MY_PN=${PN//-/.}
MY_P=${MY_PN}-${PV}

DESCRIPTION="Sphinx extension: auto-generates API docs from Zope interfaces"
HOMEPAGE="https://pypi.python.org/pypi/repoze.sphinx.autointerface/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-python/sphinx[${PYTHON_USEDEP}]
	dev-python/zope-interface[${PYTHON_USEDEP}]
"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S=${WORKDIR}/${MY_P}
