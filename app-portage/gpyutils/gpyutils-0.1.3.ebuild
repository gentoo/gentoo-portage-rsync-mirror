# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/gpyutils/gpyutils-0.1.3.ebuild,v 1.2 2014/07/06 13:16:21 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

DESCRIPTION="Utitilies for maintaining Python packages"
HOMEPAGE="https://bitbucket.org/mgorny/gpyutils/"
SRC_URI="https://www.bitbucket.org/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-portage/gentoopm-0.2.9[${PYTHON_USEDEP}]"

python_test() {
	esetup.py test
}
