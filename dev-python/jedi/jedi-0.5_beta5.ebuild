# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/jedi/jedi-0.5_beta5.ebuild,v 1.2 2015/04/08 08:05:10 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 )
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
