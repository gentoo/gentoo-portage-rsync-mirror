# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.13.3.ebuild,v 1.8 2012/11/22 21:31:43 maekke Exp $

EAPI="4"
PYTHON_DEPEND="*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit eutils python toolchain-funcs

DESCRIPTION="Python extension module generator for C and C++ libraries"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/sip/intro http://pypi.python.org/pypi/SIP"
SRC_URI="http://www.riverbankcomputing.com/static/Downloads/${PN}${PV%%.*}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 sip )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc"

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-4.9.3-darwin.patch
	sed -i -e 's/-O2//g' specs/* || die

	python_src_prepare
}

src_configure() {
	configuration() {
		local myconf=("$(PYTHON)"
			configure.py
			--bindir="${EPREFIX}/usr/bin"
			--destdir="${EPREFIX}$(python_get_sitedir)"
			--incdir="${EPREFIX}$(python_get_includedir)"
			--sipdir="${EPREFIX}/usr/share/sip"
			$(use debug && echo --debug)
			CC="$(tc-getCC)"
			CXX="$(tc-getCXX)"
			LINK="$(tc-getCXX)"
			LINK_SHLIB="$(tc-getCXX)"
			CFLAGS="${CFLAGS}"
			CXXFLAGS="${CXXFLAGS}"
			LFLAGS="${LDFLAGS}"
			STRIP=":")
		echo "${myconf[@]}"
		"${myconf[@]}"
	}
	python_execute_function -s configuration
}

src_install() {
	python_src_install

	dodoc NEWS

	if use doc; then
		dohtml -r doc/html/*
	fi
}

pkg_postinst() {
	python_mod_optimize sipconfig.py sipdistutils.py

	ewarn "When updating dev-python/sip, you usually need to rebuild packages that depend on it,"
	ewarn "such as PyQt4, qscintilla-python and pykde4. If you have app-portage/gentoolkit"
	ewarn "installed, you can find these packages with \`equery d dev-python/sip\`."
}

pkg_postrm() {
	python_mod_cleanup sipconfig.py sipdistutils.py
}
