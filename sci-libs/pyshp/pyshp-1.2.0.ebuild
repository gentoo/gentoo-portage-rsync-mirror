# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/pyshp/pyshp-1.2.0.ebuild,v 1.3 2015/04/02 18:32:50 mr_bones_ Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Pure Python read/write support for ESRI Shapefile format"
HOMEPAGE="https://pypi.python.org/pypi/pyshp/"

if [[ ${PV} == "9999" ]] ; then
	SRC_URI=""
	ESVN_REPO_URI="http://${PN}.googlecode.com/svn/trunk"
	inherit subversion
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
