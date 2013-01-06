# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.8.7.ebuild,v 1.7 2013/01/06 18:17:18 armin76 Exp $

EAPI="3"
WANT_AUTOCONF="2.1"
inherit autotools eutils toolchain-funcs multilib python versionator pax-utils

MY_PN="js"
TARBALL_PV="$(replace_all_version_separators '' $(get_version_component_range 1-3))"
MY_P="${MY_PN}-${PV}"
TARBALL_P="${MY_PN}${TARBALL_PV}-1.0.0"
SPIDERPV="${PV}-patches-0.1"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="http://people.mozilla.com/~dmandelin/${TARBALL_P}.tar.gz
	http://dev.gentoo.org/~anarchy/mozilla/patchsets/spidermonkey-${SPIDERPV}.tar.xz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa -ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug jit static-libs test"

S="${WORKDIR}/${MY_P}"
BUILDDIR="${S}/js/src"

RDEPEND=">=dev-libs/nspr-4.7.0
	virtual/libffi"
DEPEND="${RDEPEND}
	app-arch/zip
	=dev-lang/python-2*[threads]
	virtual/pkgconfig"

pkg_setup(){
	python_set_active_version 2

	export LC_ALL="C"
}

src_prepare() {
	# Apply patches that are required for misc archs
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch "${WORKDIR}/spidermonkey"

	epatch "${FILESDIR}"/${PN}-1.8.5-fix-install-symlinks.patch
	epatch "${FILESDIR}"/${PN}-1.8.7-filter_desc.patch
	epatch "${FILESDIR}"/${PN}-1.8.7-freebsd-pthreads.patch
	epatch "${FILESDIR}"/${PN}-1.8.7-x32.patch

	epatch_user

	if [[ ${CHOST} == *-freebsd* ]]; then
		# Don't try to be smart, this does not work in cross-compile anyway
		ln -sfn "${BUILDDIR}/config/Linux_All.mk" "${S}/config/$(uname -s)$(uname -r).mk"
	fi

	cd "${S}"/js/src
	eautoconf
}

src_configure() {
	cd "${BUILDDIR}"

	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" PYTHON="$(PYTHON)" \
	econf \
		${myopts} \
		--enable-jemalloc \
		--enable-readline \
		--enable-threadsafe \
		--with-system-nspr \
		--enable-system-ffi \
		--enable-jemalloc \
		$(use_enable debug) \
		$(use_enable jit tracejit) \
		$(use_enable jit methodjit) \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

src_compile() {
	cd "${BUILDDIR}"
	if tc-is-cross-compiler; then
		make CFLAGS="" CXXFLAGS="" \
			CC=$(tc-getBUILD_CC) CXX=$(tc-getBUILD_CXX) \
			jscpucfg host_jsoplengen host_jskwgen || die
		make CFLAGS="" CXXFLAGS="" \
			CC=$(tc-getBUILD_CC) CXX=$(tc-getBUILD_CXX) \
			-C config nsinstall || die
		mv {,native-}jscpucfg
		mv {,native-}host_jskwgen
		mv {,native-}host_jsoplengen
		mv config/{,native-}nsinstall
		sed -e 's@./jscpucfg@./native-jscpucfg@' \
			-e 's@./host_jskwgen@./native-host_jskwgen@' \
			-e 's@./host_jsoplengen@./native-host_jsoplengen@' \
			-i Makefile
		sed -e 's@/nsinstall@/native-nsinstall@' -i config/config.mk
		rm config/host_nsinstall.o \
			config/host_pathsub.o \
			host_jskwgen.o \
			host_jsoplengen.o
	fi
	emake || die
}

src_test() {
	cd "${BUILDDIR}/jsapi-tests"
	emake check || die
}

src_install() {
	cd "${BUILDDIR}"
	emake DESTDIR="${D}" install || die
	dobin shell/js ||die
	if use jit ; then
		pax-mark m "${ED}/usr/bin/js"
	fi
	dodoc ../../README || die
	dohtml README.html || die
	# install header files needed but not part of build system
	insinto /usr/include/js || die
	doins ../public/*.h || die
	insinto /usr/include/js/mozilla || die
	doins "${S}"/mfbt/*.h || die

	if ! use static-libs; then
		# We can't actually disable building of static libraries
		# They're used by the tests and in a few other places
		find "${D}" -iname '*.a' -delete || die
	fi
}
