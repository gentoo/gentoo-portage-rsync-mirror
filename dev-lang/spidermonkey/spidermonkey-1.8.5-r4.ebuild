# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.8.5-r4.ebuild,v 1.21 2015/03/03 06:13:08 dlan Exp $

EAPI="5"
WANT_AUTOCONF="2.1"
PYTHON_COMPAT=( python2_{6,7} )
PYTHON_REQ_USE="threads"
inherit autotools eutils toolchain-funcs multilib python-any-r1 versionator pax-utils

MY_PN="js"
TARBALL_PV="$(replace_all_version_separators '' $(get_version_component_range 1-3))"
MY_P="${MY_PN}-${PV}"
TARBALL_P="${MY_PN}${TARBALL_PV}-1.0.0"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="https://ftp.mozilla.org/pub/mozilla.org/js/${TARBALL_P}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0/mozjs185"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x64-macos"
IUSE="debug minimal static-libs test"

S="${WORKDIR}/${MY_P}"
BUILDDIR="${S}/js/src"

RDEPEND=">=dev-libs/nspr-4.7.0
	x64-macos? ( dev-libs/jemalloc )"
DEPEND="${RDEPEND}
	${PYTHON_DEPS}
	app-arch/zip
	virtual/pkgconfig"

pkg_setup(){
	if [[ ${MERGE_TYPE} != "binary" ]]; then
		export LC_ALL="C"
	fi
}

src_prepare() {
	# https://bugzilla.mozilla.org/show_bug.cgi?id=628723#c43
	epatch "${FILESDIR}/${P}-fix-install-symlinks.patch"
	# https://bugzilla.mozilla.org/show_bug.cgi?id=638056#c9
	epatch "${FILESDIR}/${P}-fix-ppc64.patch"
	# https://bugs.gentoo.org/show_bug.cgi?id=400727
	# https://bugs.gentoo.org/show_bug.cgi?id=420471
	epatch "${FILESDIR}/${P}-arm_respect_cflags-3.patch"
	# https://bugs.gentoo.org/show_bug.cgi?id=438746
	epatch "${FILESDIR}"/${PN}-1.8.7-freebsd-pthreads.patch
	# https://bugs.gentoo.org/show_bug.cgi?id=441928
	epatch "${FILESDIR}"/${PN}-1.8.5-perf_event-check.patch
	# https://bugs.gentoo.org/show_bug.cgi?id=439260
	epatch "${FILESDIR}"/${P}-symbol-versions.patch
	# https://bugs.gentoo.org/show_bug.cgi?id=441934
	epatch "${FILESDIR}"/${PN}-1.8.5-ia64-fix.patch
	epatch "${FILESDIR}"/${PN}-1.8.5-ia64-static-strings.patch
	# https://bugs.gentoo.org/show_bug.cgi?id=431560
	epatch "${FILESDIR}"/${PN}-1.8.5-isfinite.patch

	epatch_user

	cd "${BUILDDIR}" || die
	eautoconf
}

src_configure() {
	cd "${BUILDDIR}" || die

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
	AR="$(tc-getAR)" RANLIB="$(tc-getRANLIB)" \
	LD="$(tc-getLD)" \
	econf \
		${myopts} \
		--enable-jemalloc \
		--enable-readline \
		--enable-threadsafe \
		--with-system-nspr \
		$(use_enable debug) \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

src_compile() {
	cd "${BUILDDIR}" || die
	if tc-is-cross-compiler; then
		make CFLAGS="" CXXFLAGS="" \
			CC=$(tc-getBUILD_CC) CXX=$(tc-getBUILD_CXX) \
			AR=$(tc-getBUILD_AR) RANLIB=$(tc-getBUILD_RANLIB) \
			jscpucfg host_jsoplengen host_jskwgen || die
		make CFLAGS="" CXXFLAGS="" \
			CC=$(tc-getBUILD_CC) CXX=$(tc-getBUILD_CXX) \
			AR=$(tc-getBUILD_AR) RANLIB=$(tc-getBUILD_RANLIB) \
			-C config nsinstall || die
		mv {,native-}jscpucfg || die
		mv {,native-}host_jskwgen || die
		mv {,native-}host_jsoplengen || die
		mv config/{,native-}nsinstall || die
		sed -e 's@./jscpucfg@./native-jscpucfg@' \
			-e 's@./host_jskwgen@./native-host_jskwgen@' \
			-e 's@./host_jsoplengen@./native-host_jsoplengen@' \
			-i Makefile || die
		sed -e 's@/nsinstall@/native-nsinstall@' -i config/config.mk || die
		rm -f config/host_nsinstall.o \
			config/host_pathsub.o \
			host_jskwgen.o \
			host_jsoplengen.o || die
	fi
	emake
}

src_test() {
	cd "${BUILDDIR}/jsapi-tests" || die
	# for bug 415791
	pax-mark mr jsapi-tests
	emake check
}

src_install() {
	cd "${BUILDDIR}" || die
	emake DESTDIR="${D}" install
	# bug 437520 , exclude js shell for small systems
	if ! use minimal ; then
		dobin shell/js
		pax-mark m "${ED}/usr/bin/js"
	fi
	dodoc ../../README
	dohtml README.html

	if ! use static-libs; then
		# We can't actually disable building of static libraries
		# They're used by the tests and in a few other places
		find "${D}" -iname '*.a' -delete || die
	fi
}
