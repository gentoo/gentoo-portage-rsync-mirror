# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/retext/retext-4.0.1.ebuild,v 1.2 2013/06/29 15:43:37 tomwij Exp $

EAPI="5"

PYTHON_COMPAT=( python2_7 python3_2 )

inherit eutils qt4-r2 distutils-r1

MY_PN="ReText"
MY_P="${MY_PN}-${PV/_/~}"

DESCRIPTION="A Qt-based text editor for Markdown and reStructuredText"
HOMEPAGE="http://sourceforge.net/p/retext/home/ReText/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+spell"

RDEPEND+="
	dev-python/docutils[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/markups[${PYTHON_USEDEP}]
	dev-python/PyQt4[webkit,${PYTHON_USEDEP}]
	spell? ( dev-python/pyenchant[${PYTHON_USEDEP}] )
"

S="${WORKDIR}"/${MY_P}

src_install() {
	distutils-r1_src_install

	newicon {icons/,}${PN}.png
	newicon {icons/,}${PN}.svg

	make_desktop_entry "${PN}.py" "${MY_PN} Editor" "${PN}" "Development;Utility;TextEditor"
}
