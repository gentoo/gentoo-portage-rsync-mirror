# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/g-sorcery/g-sorcery-0.1-r1.ebuild,v 1.4 2014/09/29 22:45:21 jer Exp $

EAPI=5

PYTHON_COMPAT=(python{2_7,3_2,3_3})

inherit distutils-r1

DESCRIPTION="framework for ebuild generators"
HOMEPAGE="https://github.com/jauhien/g-sorcery"
SRC_URI="https://github.com/jauhien/g-sorcery/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"

PDEPEND=">=app-portage/layman-2.2.0[g-sorcery]"

python_install_all() {
	distutils-r1_python_install_all

	doman docs/*.8
	dohtml docs/developer_instructions.html
	diropts -m0777
	dodir /var/lib/g-sorcery
}
