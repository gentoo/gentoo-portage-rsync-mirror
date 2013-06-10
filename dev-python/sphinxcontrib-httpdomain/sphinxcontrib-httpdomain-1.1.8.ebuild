# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sphinxcontrib-httpdomain/sphinxcontrib-httpdomain-1.1.8.ebuild,v 1.1 2013/06/10 09:07:30 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Extension providing a Sphinx domain for describing RESTful HTTP APIs"
HOMEPAGE="http://bitbucket.org/birkenfeld/sphinx-contrib/ \
	http://packages.python.org/sphinxcontrib-httpdomain/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND=">=dev-python/sphinx-1.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
