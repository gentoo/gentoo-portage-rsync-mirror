# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyx/pyx-0.13.ebuild,v 1.1 2014/05/03 08:07:26 patrick Exp $

EAPI=5
PYTHON_COMPAT=( python3_3 )

inherit distutils-r1

MY_P="${P/pyx/PyX}"

DESCRIPTION="Python package for the generation of encapsulated PostScript figures"
HOMEPAGE="http://pyx.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyx/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc"

RDEPEND="virtual/tex-base"
DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S="${WORKDIR}/${MY_P}"

DOCS=( AUTHORS CHANGES )

src_prepare() {
	distutils-r1_src_prepare
	sed -i \
		-e 's/^build_t1code=.*/build_t1code=1/' \
		-e 's/^build_pykpathsea=.*/build_pykpathsea=1/' \
		setup.cfg || die "setup.cfg fix failed"
}

python_compile_all() {
	if use doc; then
		cd "${S}/faq"
		VARTEXFONTS="${T}"/fonts make latexpdf
	fi
}

python_install_all() {
	use doc && dodoc faq/_build/latex/pyxfaq.pdf
}
