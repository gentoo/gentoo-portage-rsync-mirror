# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-5.16.ebuild,v 1.2 2014/01/18 03:06:30 vapier Exp $

EAPI="4"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )
DISTUTILS_OPTIONAL=1

inherit eutils distutils-r1 libtool toolchain-funcs

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/glensc/file.git"
	inherit autotools git-r3
else
	SRC_URI="ftp://ftp.astron.com/pub/file/${P}.tar.gz
		ftp://ftp.gw.com/mirrors/pub/unix/file/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="http://www.darwinsys.com/file/"

LICENSE="BSD-2"
SLOT="0"
IUSE="python static-libs zlib"

DEPEND="python? ( ${PYTHON_DEPS} )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}
	python? ( !dev-python/python-magic )"

src_prepare() {
	[[ ${PV} == "9999" ]] && eautoreconf
	elibtoolize

	# don't let python README kill main README #60043
	mv python/README{,.python}
}

wd() { echo "${WORKDIR}"/build-${CHOST}; }

do_configure() {
	ECONF_SOURCE=${S}

	mkdir "$(wd)"
	pushd "$(wd)" >/dev/null

	econf "$@"

	popd >/dev/null
}

src_configure() {
	# when cross-compiling, we need to build up our own file
	# because people often don't keep matching host/target
	# file versions #362941
	if tc-is-cross-compiler && ! ROOT=/ has_version ~${CATEGORY}/${P} ; then
		tc-export_build_env BUILD_C{C,XX}
		ac_cv_header_zlib_h=no \
		ac_cv_lib_z_gzopen=no \
		CHOST=${CBUILD} \
		CFLAGS=${BUILD_CFLAGS} \
		CXXFLAGS=${BUILD_CXXFLAGS} \
		CPPFLAGS=${BUILD_CPPFLAGS} \
		LDFLAGS="${BUILD_LDFLAGS} -static" \
		CC=${BUILD_CC} \
		CXX=${BUILD_CXX} \
		do_configure --disable-shared
	fi

	export ac_cv_header_zlib_h=$(usex zlib) ac_cv_lib_z_gzopen=$(usex zlib)
	do_configure $(use_enable static-libs static)
}

do_make() {
	emake -C "$(wd)" "$@"
}

src_compile() {
	if tc-is-cross-compiler && ! ROOT=/ has_version ~${CATEGORY}/${P} ; then
		CHOST=${CBUILD} do_make -C src file
		PATH=$(CHOST=${CBUILD} wd)/src:${PATH}
	fi
	do_make

	use python && cd python && distutils-r1_src_compile
}

src_install() {
	do_make DESTDIR="${D}" install
	dodoc ChangeLog MAINT README

	use python && cd python && distutils-r1_src_install
	prune_libtool_files
}
