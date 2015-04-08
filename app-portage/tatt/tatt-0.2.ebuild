# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/tatt/tatt-0.2.ebuild,v 1.2 2015/01/07 14:17:58 tomka Exp $

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{3,4} )

inherit distutils-r1

DESCRIPTION="tatt is an arch testing tool"
HOMEPAGE="https://github.com/tom111/tatt"
SRC_URI="https://github.com/tom111/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+templates"

RDEPEND="
	app-portage/eix
	app-portage/gentoolkit
	www-client/pybugz
	dev-python/configobj[${PYTHON_USEDEP}]"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install_all() {
	distutils-r1_python_install_all
	if use templates; then
		insinto "/usr/share/${PN}"
		doins -r templates || die
	fi
	doman tatt.1
	doman tatt.5
}
