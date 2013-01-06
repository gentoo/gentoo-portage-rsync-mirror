# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac-git/trac-git-8215.ebuild,v 1.2 2010/07/05 11:00:44 hollow Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="A git plugin for Trac"
HOMEPAGE="http://trac-hacks.org/wiki/GitPlugin"
SRC_URI="http://trac-hacks.org/changeset/${PV}/gitplugin?old_path=/&format=zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND=">=www-apps/trac-0.12
	dev-vcs/git"

S="${WORKDIR}/gitplugin/0.12"

src_install() {
	distutils_src_install
	rm -f "${D}"/usr/{README,COPYING}
}
