# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libxslt/libxslt-1.1.28-r3.ebuild,v 1.12 2014/10/27 01:47:17 vapier Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="xml"

inherit autotools eutils python-r1 toolchain-funcs multilib-minimal

DESCRIPTION="XSLT libraries and tools"
HOMEPAGE="http://www.xmlsoft.org/"
SRC_URI="ftp://xmlsoft.org/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="crypt debug python static-libs"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND=">=dev-libs/libxml2-2.9.1-r4:2[${MULTILIB_USEDEP}]
	crypt?  ( >=dev-libs/libgcrypt-1.5.3:0=[${MULTILIB_USEDEP}] )
	python? (
		${PYTHON_DEPS}
		dev-libs/libxml2:2[python,${PYTHON_USEDEP}] )
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20131008-r20
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)
"
DEPEND="${RDEPEND}"

src_prepare() {
	DOCS=( AUTHORS ChangeLog FEATURES NEWS README TODO )

	# https://bugzilla.gnome.org/show_bug.cgi?id=684621
	epatch "${FILESDIR}"/${PN}.m4-${PN}-1.1.26.patch

	epatch "${FILESDIR}"/${PN}-1.1.26-disable_static_modules.patch

	# use AC_PATH_TOOL for libgcrypt-config for sane cross-compile and multilib support
	# https://bugzilla.gnome.org/show_bug.cgi?id=725635
	epatch "${FILESDIR}"/${PN}-1.1.28-libgcrypt-config.patch

	eautoreconf
	# If eautoreconf'd with new autoconf, then epunt_cxx is not necessary
	# and it is propably otherwise too if upstream generated with new
	# autoconf
#	epunt_cxx
	# But Prefix always needs elibtoolize if not eautoreconf'd.
#	elibtoolize
}

multilib_src_configure() {
	libxslt_configure() {
		ECONF_SOURCE=${S} econf \
			$(use_enable static-libs static) \
			--with-html-dir="${EPREFIX}"/usr/share/doc/${PF} \
			--with-html-subdir=html \
			$(use_with crypt crypto) \
			$(use_with debug) \
			$(use_with debug mem-debug) \
			"$@"
	}

	libxslt_py_configure() {
		mkdir -p "${BUILD_DIR}" || die # ensure python build dirs exist
		run_in_build_dir libxslt_configure "--with-python=${PYTHON}" # odd build system
	}

	libxslt_configure --without-python # build python bindings separately

	if multilib_is_native_abi && use python; then
		python_parallel_foreach_impl libxslt_py_configure
	fi
}

multilib_src_compile() {
	default
	multilib_is_native_abi && use python && libxslt_foreach_py_emake all
}

multilib_src_test() {
	default
	multilib_is_native_abi && use python && libxslt_foreach_py_emake test
}

multilib_src_install() {
	# "default" does not work here - docs are installed by multilib_src_install_all
	emake DESTDIR="${D}" install

	if multilib_is_native_abi && use python; then
		libxslt_foreach_py_emake DESTDIR="${D}" install
		python_foreach_impl python_optimize
		mv "${ED}"/usr/share/doc/${PN}-python-${PV} "${ED}"/usr/share/doc/${PF}/python
	fi

	prune_libtool_files --modules
}

libxslt_foreach_py_emake() {
	libxslt_py_emake() {
		pushd "${BUILD_DIR}/python" > /dev/null || die
		emake "$@"
		popd > /dev/null
	}
	local native_builddir=${BUILD_DIR}
	python_foreach_impl libxslt_py_emake top_builddir="${native_builddir}" "$@"
}
