# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jedi/jedi-0.6.0.ebuild,v 1.3 2013/06/25 12:50:33 ago Exp $

EAPI=5

PYTHON_COMPAT=( python2_6 python2_7 python3_2 python3_3 )
inherit distutils-r1

MY_PV="${PV/_beta/b}"

DESCRIPTION="Awesome autocompletion library for python"
HOMEPAGE="https://github.com/davidhalter/jedi"
SRC_URI="mirror://pypi/j/jedi/jedi-${MY_PV}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"

S=${WORKDIR}/${PN}-${MY_PV}
