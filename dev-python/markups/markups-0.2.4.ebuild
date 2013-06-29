# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/markups/markups-0.2.4.ebuild,v 1.1 2013/06/29 12:23:47 tomwij Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 python3_2 )

inherit distutils-r1

MY_PN="Markups"
MY_P=${MY_PN}-${PV}

DESCRIPTION="A wrapper around various text markups"
HOMEPAGE="http://pypi.python.org/pypi/Markups"
SRC_URI="mirror://pypi/M/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}"/${MY_P}
