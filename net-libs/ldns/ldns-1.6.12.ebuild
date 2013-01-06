# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/ldns/ldns-1.6.12.ebuild,v 1.5 2012/07/16 01:13:05 floppym Exp $

EAPI="3"
PYTHON_DEPEND="python? 2:2.5"

inherit autotools eutils python

DESCRIPTION="ldns is a library with the aim to simplify DNS programing in C"
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc-macos ~x64-macos"
IUSE="doc gost python ssl static-libs vim-syntax"

RESTRICT="test" # 1.6.9 has no test directory

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7 )
	gost? ( >=dev-libs/openssl-1 )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	doc? ( app-doc/doxygen )"

pkg_setup() {
	use python && python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/1.6.12-cflags.patch"

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable gost) \
		$(use_enable ssl sha2) \
		$(use_enable static-libs static) \
		$(use_with ssl) \
		$(use_with python pyldns) \
		--disable-rpath || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
	if use doc ; then
		emake doxygen || die "emake doxygen failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc Changelog README* || die "dodoc failed"

	if use python ; then
		find "${ED}$(python_get_sitedir)" "(" -name "*.a" -o -name "*.la" ")" -type f -delete || die
	fi

	if ! use static-libs ; then
		find "${ED}" -name "*.la" -type f -delete || die
	fi

	if use doc ; then
		dohtml doc/html/* || die "dohtml failed"
	fi

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles/ftdetect
		doins libdns.vim || die "doins libdns.vim failed"
	fi
}
