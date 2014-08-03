# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/supernova/supernova-1.0.1.ebuild,v 1.1 2014/08/03 20:06:30 alunduil Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=TRUE

inherit bash-completion-r1 distutils-r1 vcs-snapshot

DESCRIPTION="Use novaclient with multiple OpenStack nova environments the easy way"
HOMEPAGE="https://github.com/rackerhacker/supernova"
SRC_URI="https://github.com/major/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion doc examples"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
RDEPEND="
	${PYTHON_DEPS}
	>=dev-python/keyring-0.9.2[${PYTHON_USEDEP}]
	dev-python/rackspace-novaclient[${PYTHON_USEDEP}]
"

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( example_configs/. )

	distutils-r1_python_install_all

	use bash-completion && newbashcomp contrib/${PN}-completion.bash ${PN}
}
