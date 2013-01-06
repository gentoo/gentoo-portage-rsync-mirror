# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sip/sip-4.14.2.ebuild,v 1.1 2012/12/10 11:06:59 pesa Exp $

EAPI="5"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit eutils python toolchain-funcs

DESCRIPTION="Python extension module generator for C and C++ libraries"
HOMEPAGE="http://www.riverbankcomputing.co.uk/software/sip/intro http://pypi.python.org/pypi/SIP"
LICENSE="|| ( GPL-2 GPL-3 sip )"

if [[ ${PV} == *9999* ]]; then
	# live version from mercurial repo
	EHG_REPO_URI="http://www.riverbankcomputing.com/hg/sip"
	inherit mercurial
elif [[ ${PV} == *_pre* ]]; then
	# development snapshot
	HG_REVISION=
	MY_P=${PN}-${PV%_pre*}-snapshot-${HG_REVISION}
	SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${MY_P}.tar.gz"
	S=${WORKDIR}/${MY_P}
else
	# official release
	SRC_URI="mirror://sourceforge/pyqt/${P}.tar.gz"
fi

# Sub-slot based on SIP_API_MAJOR_NR from siplib/sip.h.in
SLOT="0/9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug doc"

DEPEND=""
RDEPEND="${DEPEND}"
[[ ${PV} == *9999* ]] && DEPEND+="
	sys-devel/bison
	sys-devel/flex
	doc? ( dev-python/sphinx )
"

src_prepare() {
	if [[ ${PV} == *9999* ]]; then
		$(PYTHON -2) build.py prepare || die
		if use doc; then
			$(PYTHON -2) build.py doc || die
		fi
	fi

	# Sub-slot sanity check
	local sub_slot=${SLOT#*/}
	local sip_api_major_nr=$(sed -nre 's:^#define SIP_API_MAJOR_NR\s+([0-9]+):\1:p' siplib/sip.h.in)
	if [[ ${sub_slot} != ${sip_api_major_nr} ]]; then
		eerror
		eerror "Ebuild sub-slot (${sub_slot}) does not match SIP_API_MAJOR_NR (${sip_api_major_nr})"
		eerror "Please update SLOT variable as follows:"
		eerror "    SLOT=\"${SLOT%%/*}/${sip_api_major_nr}\""
		eerror
		die "sub-slot sanity check failed"
	fi

	epatch "${FILESDIR}"/${PN}-4.9.3-darwin.patch

	python_src_prepare
}

src_configure() {
	configuration() {
		local myconf=(
			"$(PYTHON)" configure.py
			--bindir="${EPREFIX}/usr/bin"
			--destdir="${EPREFIX}$(python_get_sitedir)"
			--incdir="${EPREFIX}$(python_get_includedir)"
			--sipdir="${EPREFIX}/usr/share/sip"
			$(use debug && echo --debug)
			AR="$(tc-getAR) cqs"
			CC="$(tc-getCC)"
			CFLAGS="${CFLAGS}"
			CFLAGS_RELEASE=
			CXX="$(tc-getCXX)"
			CXXFLAGS="${CXXFLAGS}"
			CXXFLAGS_RELEASE=
			LINK="$(tc-getCXX)"
			LINK_SHLIB="$(tc-getCXX)"
			LFLAGS="${LDFLAGS}"
			LFLAGS_RELEASE=
			RANLIB=
			STRIP=
		)
		echo "${myconf[@]}"
		"${myconf[@]}"
	}
	python_execute_function -s configuration
}

src_install() {
	python_src_install

	dodoc NEWS
	use doc && dohtml -r doc/html/*
}

pkg_postinst() {
	python_mod_optimize sipconfig.py sipdistutils.py
}

pkg_postrm() {
	python_mod_cleanup sipconfig.py sipdistutils.py
}
