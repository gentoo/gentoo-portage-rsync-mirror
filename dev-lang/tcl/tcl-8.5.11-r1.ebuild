# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcl/tcl-8.5.11-r1.ebuild,v 1.2 2012/12/05 08:51:01 ulm Exp $

EAPI=4

inherit versionator autotools eutils flag-o-matic multilib toolchain-funcs

MY_P="${PN}${PV/_beta/b}"

DESCRIPTION="Tool Command Language"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${MY_P}-src.tar.gz"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="debug threads"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use threads ; then
		echo
		ewarn "PLEASE NOTE: You are compiling ${P} with"
		ewarn "threading enabled."
		ewarn "Threading is not supported by all applications"
		ewarn "that compile against tcl. You use threading at"
		ewarn "your own discretion."
		echo
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-8.5_alpha6-multilib.patch

	# Bug 125971
	epatch "${FILESDIR}"/${PN}-8.5_alpha6-tclm4-soname.patch

	# Bug 354067
	epatch "${FILESDIR}"/${PN}-8.5.9-gentoo-fbsd.patch

	cd "${S}"/unix
	eautoreconf
}

src_configure() {
	# workaround stack check issues, bug #280934
	if use hppa; then
		append-cflags "-DTCL_NO_STACK_CHECK=1"
	fi

	tc-export CC

	cd "${S}"/unix
	econf \
		$(use_enable threads) \
		$(use_enable debug symbols)
}

src_compile() {
	cd "${S}"/unix &&	emake
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}

	cd "${S}"/unix
	S= emake DESTDIR="${D}" install

	# fix the tclConfig.sh to eliminate refs to the build directory
	# and drop unnecessary -L inclusion to default system libdir
	local mylibdir=$(get_libdir) ; mylibdir=${mylibdir//\/}
	sed -i \
		-e "s,^TCL_BUILD_LIB_SPEC='-L.*/unix ,TCL_BUILD_LIB_SPEC='," \
		-e "s,^TCL_SRC_DIR='.*',TCL_SRC_DIR='${EPREFIX}/usr/${mylibdir}/tcl${v1}/include'," \
		-e "s,^TCL_BUILD_STUB_LIB_SPEC='-L.*/unix ,TCL_BUILD_STUB_LIB_SPEC='," \
		-e "s,^TCL_BUILD_STUB_LIB_PATH='.*/unix,TCL_BUILD_STUB_LIB_PATH='${EPREFIX}/usr/${mylibdir}," \
		-e "s,^TCL_LIB_FILE='libtcl${v1}..TCL_DBGX..so',TCL_LIB_FILE=\"libtcl${v1}\$\{TCL_DBGX\}.so\"," \
		-e "s,^TCL_STUB_LIB_SPEC='-L${EPREFIX}/usr/${mylibdir} ,TCL_STUB_LIB_SPEC='," \
		-e "s,^TCL_LIB_SPEC='-L${EPREFIX}/usr/${mylibdir} ,TCL_LIB_SPEC='," \
		"${ED}"/usr/${mylibdir}/tclConfig.sh || die
	if [[ ${CHOST} != *-darwin* && ${CHOST} != *-mint* ]] ; then
		sed -i \
			-e "s,^TCL_CC_SEARCH_FLAGS='\(.*\)',TCL_CC_SEARCH_FLAGS='\1:${EPREFIX}/usr/${mylibdir}'," \
			-e "s,^TCL_LD_SEARCH_FLAGS='\(.*\)',TCL_LD_SEARCH_FLAGS='\1:${EPREFIX}/usr/${mylibdir}'," \
			"${ED}"/usr/${mylibdir}/tclConfig.sh || die
	fi

	# install private headers
	insinto /usr/${mylibdir}/tcl${v1}/include/unix
	doins "${S}"/unix/*.h
	insinto /usr/${mylibdir}/tcl${v1}/include/generic
	doins "${S}"/generic/*.h
	rm -f "${ED}"/usr/${mylibdir}/tcl${v1}/include/generic/tcl.h || die
	rm -f "${ED}"/usr/${mylibdir}/tcl${v1}/include/generic/tclDecls.h || die
	rm -f "${ED}"/usr/${mylibdir}/tcl${v1}/include/generic/tclPlatDecls.h || die

	# install symlink for libraries
	dosym libtcl${v1}$(get_libname) /usr/${mylibdir}/libtcl$(get_libname)
	dosym libtclstub${v1}.a /usr/${mylibdir}/libtclstub.a

	dosym tclsh${v1} /usr/bin/tclsh

	cd "${S}"
	dodoc ChangeLog* README changes
}

pkg_postinst() {
	for version in ${REPLACING_VERSIONS}; do
		if ! version_is_at_least 8.5 ${version}; then
			echo
			ewarn "You're upgrading from <dev-lang/tcl-8.5, you must recompile the other"
			ewarn "packages on your system that link with tcl after the upgrade"
			ewarn "completes. To perform this action, please run revdep-rebuild"
			ewarn "in package app-portage/gentoolkit."
			ewarn "If you have dev-lang/tk and dev-tcltk/tclx installed you should"
			ewarn "upgrade them before this recompilation, too,"
			echo
		fi
	done
}
