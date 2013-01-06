# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/tatt/tatt-9999.ebuild,v 1.4 2011/09/13 13:54:56 tomka Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.6"

inherit distutils git-2

DESCRIPTION="tatt is an arch testing tool"
HOMEPAGE="http://github.com/tom111/tatt"
EGIT_REPO_URI="git://github.com/tom111/tatt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+templates"

DEPEND="dev-python/setuptools"
RDEPEND="app-portage/eix
		app-portage/gentoolkit
		www-client/pybugz
		dev-python/configobj"

#configobj does not support python-3
RESTRICT_PYTHON_ABIS="2.[45] 3.*"

S="${WORKDIR}/${PN}"

src_install() {
	distutils_src_install
	if use templates; then
		insinto "/usr/share/${PN}"
		doins -r templates || die
	fi
}
