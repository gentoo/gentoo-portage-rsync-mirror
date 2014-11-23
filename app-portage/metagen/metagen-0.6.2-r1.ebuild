# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/metagen/metagen-0.6.2-r1.ebuild,v 1.8 2014/11/23 14:07:06 zlogene Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="metadata.xml generator for ebuilds"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/metagen.git;a=summary"
SRC_URI="http://dev.gentoo.org/~neurogeek/metagen_releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86 ~amd64-linux ~x86-linux"

IUSE=""
DEPEND=">=dev-python/jaxml-3.01[${PYTHON_USEDEP}]
	>=sys-apps/portage-2.1.9.42[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

python_install() {
	distutils-r1_python_install
	python_newscript metagen/main.py metagen
}

python_install_all() {
	distutils-r1_python_install_all
	doman docs/metagen.1
}

python_test() {
	"${PYTHON}" -c "from metagen import metagenerator; metagenerator.do_tests()" || die
}
