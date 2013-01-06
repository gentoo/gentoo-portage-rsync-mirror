# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyx/pyx-0.12.1.ebuild,v 1.1 2012/11/14 07:24:36 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

MY_P="${P/pyx/PyX}"

DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
HOMEPAGE="http://pyx.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyx/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="virtual/tex-base"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S="${WORKDIR}/${MY_P}"

DOCS="AUTHORS CHANGES"

src_prepare() {
	distutils_src_prepare
	sed -i \
		-e 's/^build_t1code=.*/build_t1code=1/' \
		-e 's/^build_pykpathsea=.*/build_pykpathsea=1/' \
		setup.cfg || die "setup.cfg fix failed"
}

src_compile() {
	distutils_src_compile
	if use doc; then
		cd "${S}/faq"
		VARTEXFONTS="${T}"/fonts make pdf
	fi
}

src_install() {
	distutils_src_install
	use doc && dodoc faq/pyxfaq.pdf
}
