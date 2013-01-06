# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/tcl/tcl-8.4.19.ebuild,v 1.6 2012/12/05 08:51:01 ulm Exp $

inherit autotools eutils multilib toolchain-funcs

DESCRIPTION="Tool Command Language"
HOMEPAGE="http://www.tcl.tk/"
SRC_URI="mirror://sourceforge/tcl/${PN}${PV}-src.tar.gz"

LICENSE="tcltk"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="debug threads"

S="${WORKDIR}/${PN}${PV}"

pkg_setup() {
	if use threads ; then
		ewarn ""
		ewarn "PLEASE NOTE: You are compiling ${P} with"
		ewarn "threading enabled."
		ewarn "Threading is not supported by all applications"
		ewarn "that compile against tcl. You use threading at"
		ewarn "your own discretion."
		ewarn ""
		epause 5
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-8.4.16-multilib.patch

	# Bug 125971
	epatch "${FILESDIR}"/${PN}-8.4.15-tclm4-soname.patch
	# cross-compile fix from buildroot.
	epatch "${FILESDIR}"/${PN}-8.4.9-strtod.patch

	local d
	for d in */configure ; do
		cd "${S}"/${d%%/*}
		EPATCH_SINGLE_MSG="Patching nls cruft in ${d}" \
		epatch "${FILESDIR}"/tcl-configure-LANG.patch
	done

	cd "${S}"/unix
	eautoreconf
}

src_compile() {
	tc-export CC
	local local_config_use=""

	if use threads ; then
		local_config_use="--enable-threads"
	fi

	cd "${S}"/unix
	econf \
		$(use_enable threads) \
		$(use_enable debug symbols)
	emake || die
}

src_install() {
	#short version number
	local v1
	v1=${PV%.*}

	cd "${S}"/unix
	S= emake DESTDIR="${D}" install || die

	# fix the tclConfig.sh to eliminate refs to the build directory
	local mylibdir=$(get_libdir) ; mylibdir=${mylibdir//\/}
	sed -i \
		-e "s,^TCL_BUILD_LIB_SPEC='-L.*/unix,TCL_BUILD_LIB_SPEC='-L$/usr/${mylibdir}," \
		-e "s,^TCL_SRC_DIR='.*',TCL_SRC_DIR='/usr/${mylibdir}/tcl${v1}/include'," \
		-e "s,^TCL_BUILD_STUB_LIB_SPEC='-L.*/unix,TCL_BUILD_STUB_LIB_SPEC='-L/usr/${mylibdir}," \
		-e "s,^TCL_BUILD_STUB_LIB_PATH='.*/unix,TCL_BUILD_STUB_LIB_PATH='/usr/${mylibdir}," \
		-e "s,^TCL_LIB_FILE='libtcl${v1}..TCL_DBGX..so',TCL_LIB_FILE=\"libtcl${v1}\$\{TCL_DBGX\}.so\"," \
		-e "s,^TCL_CC_SEARCH_FLAGS='\(.*\)',TCL_CC_SEARCH_FLAGS='\1:/usr/${mylibdir}'," \
		-e "s,^TCL_LD_SEARCH_FLAGS='\(.*\)',TCL_LD_SEARCH_FLAGS='\1:/usr/${mylibdir}'," \
		"${D}"/usr/${mylibdir}/tclConfig.sh || die

	# install private headers
	insinto /usr/${mylibdir}/tcl${v1}/include/unix
	doins "${S}"/unix/*.h || die
	insinto /usr/${mylibdir}/tcl${v1}/include/generic
	doins "${S}"/generic/*.h || die
	rm -f "${D}"/usr/${mylibdir}/tcl${v1}/include/generic/tcl.h
	rm -f "${D}"/usr/${mylibdir}/tcl${v1}/include/generic/tclDecls.h
	rm -f "${D}"/usr/${mylibdir}/tcl${v1}/include/generic/tclPlatDecls.h

	# install symlink for libraries
	if use debug ; then
		dosym libtcl${v1}g.so /usr/${mylibdir}/libtcl${v1}.so
		dosym libtclstub${v1}g.a /usr/${mylibdir}/libtclstub${v1}.a
	fi
	dosym libtcl${v1}.so /usr/${mylibdir}/libtcl.so
	dosym libtclstub${v1}.a /usr/${mylibdir}/libtclstub.a

	dosym tclsh${v1} /usr/bin/tclsh

	cd "${S}"
	dodoc ChangeLog* README changes
}

pkg_postinst() {
	ewarn
	ewarn "If you're upgrading from tcl-8.3, you must recompile the other"
	ewarn "packages on your system that link with tcl after the upgrade"
	ewarn "completes.  To perform this action, please run revdep-rebuild"
	ewarn "in package app-portage/gentoolkit."
	ewarn "If you have dev-lang/tk and dev-tcltk/tclx installed you should"
	ewarn "upgrade them before this recompilation, too,"
	ewarn
}
