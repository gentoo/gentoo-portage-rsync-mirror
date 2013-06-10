# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/tatt/tatt-9999.ebuild,v 1.7 2013/06/10 14:01:05 tomka Exp $

EAPI=5

#configobj does not support python-3
PYTHON_COMPAT=( python2_6 python2_7 )

inherit distutils-r1 git-2

DESCRIPTION="tatt is an arch testing tool"
HOMEPAGE="http://github.com/tom111/tatt"
EGIT_REPO_URI="https://github.com/tom111/tatt.git \
	git://github.com/tom111/tatt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+templates"

RDEPEND="
	${PYTHON_DEPS}
	app-portage/eix
	app-portage/gentoolkit
	www-client/pybugz
	dev-python/configobj"
DEPEND="
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${PN}"

python_install_all() {
	distutils-r1_python_install_all
	if use templates; then
		insinto "/usr/share/${PN}"
		doins -r templates
	fi
	doman tatt.1
	doman tatt.5
}
