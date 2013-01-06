# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bam/bam-0.4.0.ebuild,v 1.5 2012/07/22 17:32:58 pacho Exp $

EAPI=4
PYTHON_DEPEND="2"

inherit eutils python toolchain-funcs

DESCRIPTION="Fast and flexible Lua-based build system"
HOMEPAGE="http://matricks.github.com/bam/"
SRC_URI="http://github.com/downloads/matricks/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc test"

RDEPEND="dev-lang/lua"
DEPEND="${RDEPEND}
	doc? ( dev-lang/python )
	test? ( dev-lang/python )"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}"/${PV}/Makefile "${S}"/Makefile || die "cp failed"
	epatch "${FILESDIR}"/${PV}/${P}-test.py.patch
	python_convert_shebangs -r 2 .
	tc-export CC
}

src_compile() {
	emake ${PN}
	if use doc; then
		$(PYTHON) scripts/gendocs.py || die "doc generation failed"
	fi
}

src_install() {
	dobin ${PN}
	if use doc; then
		dohtml docs/${PN}{.html,_logo.png}
	fi
}
