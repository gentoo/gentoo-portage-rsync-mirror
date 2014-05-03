# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/wtf-peewee/wtf-peewee-0.2.0.ebuild,v 1.1 2014/05/03 08:03:02 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

RESTRICT="test" # broken

DESCRIPTION="Small python ORM"
HOMEPAGE="https://github.com/coleifer/peewee/"
SRC_URI="https://github.com/coleifer/${PN}/archive/${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-python/wtforms[${PYTHON_USEDEP}]
	"
python_test() {
	nosetests || die "Testing failed with ${EPYTHON}"
}
