# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/bkchem/bkchem-0.14.0_pre1-r2.ebuild,v 1.4 2010/07/11 16:58:10 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
PYTHON_USE_WITH="tk"

inherit distutils eutils versionator

MY_P="${PN}-$(replace_version_separator 3 -)"

DESCRIPTION="Chemical drawing program"
HOMEPAGE="http://bkchem.zirael.org/"
SRC_URI="http://bkchem.zirael.org/download/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"
IUSE="cairo"

DEPEND="cairo? ( dev-python/pycairo[svg] )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${MY_P}

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-piddle-Fix-assertions.patch
	distutils_src_prepare
}

src_install() {
	distutils_src_install "--strip=${D%/}"
	sed "s:^python:$(PYTHON):g" -i "${ED}"/usr/bin/${PN} || die
	make_desktop_entry "${EPREFIX}"/usr/bin/bkchem BKChem "${EPREFIX}"/usr/share/${PN}/images/${PN}.png
}
