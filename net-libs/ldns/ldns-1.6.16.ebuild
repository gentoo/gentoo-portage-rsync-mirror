# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ldns/ldns-1.6.16.ebuild,v 1.8 2013/12/25 09:35:01 maekke Exp $

EAPI="4"
PYTHON_DEPEND="python? 2:2.5"

inherit eutils python

DESCRIPTION="a library with the aim to simplify DNS programming in C"
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~ppc-macos ~x64-macos"
IUSE="doc gost +ecdsa python +ssl static-libs vim-syntax"

RESTRICT="test" # 1.6.9 has no test directory

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7 )
	ecdsa? ( >=dev-libs/openssl-1.0.1c[-bindist] )
	gost? ( >=dev-libs/openssl-1 )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	doc? ( app-doc/doxygen )"

# configure will die if ecdsa is enabled and ssl is not
REQUIRED_USE="ecdsa? ( ssl )"

pkg_setup() {
	use python && python_set_active_version 2
	use python && python_pkg_setup
}

src_configure() {
	econf \
		$(use_enable ecdsa) \
		$(use_enable gost) \
		$(use_enable ssl sha2) \
		$(use_enable static-libs static) \
		$(use_with ssl) \
		$(use_with python pyldns) \
		$(use_with python pyldnsx) \
		--without-drill \
		--without-examples \
		--disable-rpath
}

src_compile() {
	default

	if use doc ; then
		emake doxygen
	fi
}

src_install() {
	default

	dodoc Changelog README*

	if use python ; then
		find "${ED}$(python_get_sitedir)" "(" -name "*.a" -o -name "*.la" ")" -type f -delete || die
	fi

	if ! use static-libs ; then
		find "${ED}" -name "*.la" -type f -delete || die
	fi

	if use doc ; then
		dohtml doc/html/*
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins libdns.vim
	fi

	einfo
	elog "Install net-dns/ldns-utils if you want drill and examples"
	einfo
}

pkg_postinst() {
	use python && python_mod_optimize ldns.py ldnsx.py
}

pkg_postrm() {
	use python && python_mod_cleanup ldns.py ldnsx.py
}
