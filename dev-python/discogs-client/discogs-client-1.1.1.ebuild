# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/discogs-client/discogs-client-1.1.1.ebuild,v 1.5 2015/04/08 08:05:09 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

DESCRIPTION="Official Python API client for Discogs"
HOMEPAGE="http://github.com/discogs/discogs_client http://pypi.python.org/pypi/discogs-client"
#SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"
SRC_URI="https://github.com/discogs/${PN/-/_}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]"
RDEPEND=""

S="${WORKDIR}"/${P/-/_}

PATCHES=( "${FILESDIR}"/README.patch )

python_test() {
	if "${PYTHON}" test_discogs_client.py; then
		einfo "tests passed under ${EPYTHON}"
	else
		die "Tests failed under ${EPYTHON}"
	fi
}
