# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/hubbub/hubbub-0.1.2.ebuild,v 1.3 2012/07/18 14:24:39 mr_bones_ Exp $

EAPI=4

inherit multilib toolchain-funcs

DESCRIPTION="HTML5 compliant parsing library, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/hubbub/"
SRC_URI="http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="doc static-libs test"

RDEPEND="dev-libs/libparserutils"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	virtual/libiconv
	doc? ( app-doc/doxygen )
	test? ( dev-lang/perl
		dev-libs/json-c )"

# json_object_get_string_len does not exist
RESTRICT="test"

src_prepare() {
	sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
		-e "s:-Werror::g" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i lib${PN}.pc.in || die
	echo "Q := " >> Makefile.config.override
	echo "CC := $(tc-getCC)" >> Makefile.config.override
	echo "AR := $(tc-getAR)" >> Makefile.config.override
}

src_compile() {
	emake COMPONENT_TYPE=lib-shared
	use static-libs && emake COMPONENT_TYPE=lib-static
	use doc && emake docs
}

src_test() {
	emake COMPONENT_TYPE=lib-shared test
	use static-libs && emake COMPONENT_TYPE=lib-static test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-shared install
    use static-libs && \
		emake DESTDIR="${D}" PREFIX=/usr COMPONENT_TYPE=lib-static install

	dodoc README docs/{Architecture,Macros,Todo,Treebuilder,Updated}
	use doc && dohtml build/docs/html/*
}
