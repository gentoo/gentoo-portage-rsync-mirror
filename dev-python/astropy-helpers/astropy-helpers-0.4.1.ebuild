# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/astropy-helpers/astropy-helpers-0.4.1.ebuild,v 1.1 2014/08/12 08:02:24 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="Helpers for Astropy and Affiliated packages"
HOMEPAGE="https://github.com/astropy/astropy-helpers"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86 ~x86-linux"

python_prepare_all() {
	sed -e '/import ah_bootstrap/d' -i setup.py || die "Removing ah_bootstrap failed"
	distutils-r1_python_prepare_all
}
