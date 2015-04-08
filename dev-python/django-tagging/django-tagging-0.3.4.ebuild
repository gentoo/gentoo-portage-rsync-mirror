# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-tagging/django-tagging-0.3.4.ebuild,v 1.1 2015/03/05 19:16:30 grobian Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1

DESCRIPTION="Generic tagging application for Django"
HOMEPAGE="http://code.google.com/p/django-tagging/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/django-1.0[${PYTHON_USEDEP}]"

python_install_all() {
	use doc && DOCS=( docs/. )
	distutils-r1_python_install_all
}
