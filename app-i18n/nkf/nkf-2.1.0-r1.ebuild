# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/nkf/nkf-2.1.0-r1.ebuild,v 1.4 2012/12/07 19:18:19 ulm Exp $

EAPI="3"
PYTHON_DEPEND="python? 2"
inherit eutils distutils perl-module toolchain-funcs

DESCRIPTION="Network Kanji code conversion Filter with UTF-8/16 support"
HOMEPAGE="http://sourceforge.jp/projects/nkf/"
SRC_URI="mirror://sourceforge.jp/nkf/44486/${P}.tar.gz
	python? ( http://city.plala.jp/moin/NkfPython?action=AttachFile&do=get&target=NKF_python20090602.tgz -> NKF_python20090602.tgz )"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-macos"
IUSE="perl python linguas_ja"

pkg_setup() {
	if use python ; then
		python_set_active_version 2
	fi
}

src_prepare() {
	sed -i \
		-e "/^CFLAGS/s:-O2:${CFLAGS}:" \
		-e '/-o nkf/s:$(CFLAGS):$(CFLAGS) $(LDFLAGS):' \
		Makefile || die

	if use python; then
		mv "${WORKDIR}/NKF.python" "${S}" || die
		sed -i -e "s/-s/${CFLAGS}/" NKF.python/setup.py || die
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" nkf || die
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_compile
	fi
	if use python; then
		cd "${S}/NKF.python"
		distutils_src_compile
	fi
}

src_test() {
	emake test || die
	if use perl; then
		cd "${S}/NKF.mod"
		perl-module_src_test
	fi
}

src_install() {
	dobin nkf || die
	doman nkf.1
	if use linguas_ja; then
		./nkf -e nkf.1j > nkf.1
		doman -i18n=ja nkf.1
	fi
	dodoc nkf.doc
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
	if use python ; then
		distutils_pkg_postinst
	fi
}

pkg_postrm() {
	if use python ; then
		distutils_pkg_postrm
	fi
}
