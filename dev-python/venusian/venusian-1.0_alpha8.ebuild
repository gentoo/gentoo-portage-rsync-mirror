# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/venusian/venusian-1.0_alpha8.ebuild,v 1.1 2014/03/14 08:16:28 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

RESTRICT="test"

inherit distutils-r1

MY_P="${PN}-1.0a8" # Sigh

DESCRIPTION="A library for deferring decorator actions"
HOMEPAGE="http://www.pylonsproject.org/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${MY_P}.tar.gz"

LICENSE="repoze"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
	"

S="${WORKDIR}/${MY_P}"

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
