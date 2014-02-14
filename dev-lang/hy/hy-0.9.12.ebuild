# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/hy/hy-0.9.12.ebuild,v 1.1 2014/02/14 09:13:35 patrick Exp $

EAPI=5

#RESTRICT="test" # needs some pointy sticks
PYTHON_COMPAT=(python2_7 python3_3)

inherit distutils-r1
DESCRIPTION="A LISP dialect running in python"
HOMEPAGE="http://hylang.org/"
SRC_URI="https://github.com/hylang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-python/flake8
	>=dev-python/rply-0.7.0"
DEPEND="${RDEPEND}
	test? ( dev-python/tox
		dev-python/nose
		dev-python/sphinx
		dev-python/coverage
		dev-python/astor
	)"

python_test() {
	nosetests || die "Tests failed under ${EPYTHON}"
}
