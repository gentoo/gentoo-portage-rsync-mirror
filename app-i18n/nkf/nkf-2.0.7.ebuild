# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.0.7.ebuild,v 1.10 2012/12/07 19:18:19 ulm Exp $

EAPI="3"

inherit toolchain-funcs eutils perl-app distutils

MY_P="nkf${PV//./}"
DESCRIPTION="Network Kanji code conversion Filter with UTF-8/16 support"
HOMEPAGE="http://sourceforge.jp/projects/nkf/"
SRC_URI="mirror://sourceforge.jp/nkf/20770/${MY_P}.tar.gz
	python? ( http://city.plala.jp/download/nkf/NKF_python.tgz )"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sh sparc x86"
IUSE="perl python linguas_ja"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i -e '/-o nkf/s:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' Makefile || die

	if use python; then
		unpack NKF_python.tgz
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" nkf || die
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_compile
		perl-module_src_test
	fi
	if use python; then
		cd "${S}/NKF.python"
		distutils_src_compile
	fi
}

src_install() {
	dobin nkf || die
	doman nkf.1
	if use linguas_ja; then
		./nkf -e nkf.1j > nkf.1
		doman -i18n=ja nkf.1
	fi
	dodoc INSTALL* nkf.doc
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_install
	fi
	if use python; then
		cd "${S}/NKF.python"
		distutils_src_install
	fi
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
