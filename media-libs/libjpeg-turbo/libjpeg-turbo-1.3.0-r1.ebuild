# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libjpeg-turbo/libjpeg-turbo-1.3.0-r1.ebuild,v 1.5 2013/07/31 21:28:57 aballier Exp $

EAPI=5

JPEG_ABI=8

if [[ ${PV} == *_p20* ]]; then
	SRC_URI="mirror://gentoo/${P}.tar.xz"
	inherit autotools
elif [[ ${PV} != "9999" ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
fi

inherit eutils java-pkg-opt-2 libtool toolchain-funcs multilib-minimal

DESCRIPTION="MMX, SSE, and SSE2 SIMD accelerated JPEG library"
HOMEPAGE="http://libjpeg-turbo.virtualgl.org/ http://sourceforge.net/projects/libjpeg-turbo/"
SRC_URI="${SRC_URI}
	mirror://debian/pool/main/libj/libjpeg${JPEG_ABI}/libjpeg${JPEG_ABI}_${JPEG_ABI}d-1.debian.tar.gz"

LICENSE="BSD IJG"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE="java static-libs"

ASM_DEPEND="|| ( dev-lang/nasm dev-lang/yasm )"
COMMON_DEPEND="!media-libs/jpeg:0"
RDEPEND="${COMMON_DEPEND}
	java? ( >=virtual/jre-1.5 )
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-baselibs-20130224-r3
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)] )"
DEPEND="${COMMON_DEPEND}
	amd64? ( ${ASM_DEPEND} )
	x86? ( ${ASM_DEPEND} )
	amd64-fbsd? ( ${ASM_DEPEND} )
	x86-fbsd? ( ${ASM_DEPEND} )
	amd64-linux? ( ${ASM_DEPEND} )
	x86-linux? ( ${ASM_DEPEND} )
	x64-macos? ( ${ASM_DEPEND} )
	java? ( >=virtual/jdk-1.5 )"

MULTILIB_WRAPPED_HEADERS=( /usr/include/jconfig.h )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.2.0-x32.patch #420239

	if [[ -x ./configure ]]; then
		elibtoolize
	else
		eautoreconf
	fi

	epunt_cxx #424689

	java-pkg-opt-2_src_prepare
}

multilib_src_configure() {
	local myconf=()
	if [[ ${ABI} == ${DEFAULT_ABI} ]]; then
		myconf+=( $(use_with java) )
		if use java; then
			export JAVACFLAGS="$(java-pkg_javac-args)"
			export JNI_CFLAGS="$(java-pkg_get-jni-cflags)"
		fi
	else
		myconf+=( --without-java )
	fi
	[[ ${ABI} == "x32" ]] && myconf+=( --without-simd ) #420239

	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		--with-jpeg${JPEG_ABI} \
		"${myconf[@]}"
}

multilib_src_compile() {
	local _java_makeopts
	use java && _java_makeopts="-j1"
	emake ${_java_makeopts}

	if [[ ${ABI} == ${DEFAULT_ABI} ]]; then
		ebegin "Building exifautotran and jpegexiforient extra tools"
		pushd ../debian/extra >/dev/null
		emake CC="$(tc-getCC)" CFLAGS="${LDFLAGS} ${CFLAGS}"
		popd >/dev/null
		eend $?
	fi
}

multilib_src_test() {
	emake test
}

multilib_src_install() {
	emake \
		DESTDIR="${D}" \
		docdir="${EPREFIX}"/usr/share/doc/${PF} \
		exampledir="${EPREFIX}"/usr/share/doc/${PF} \
		install

	if [[ ${ABI} == ${DEFAULT_ABI} ]] && use java; then
		insinto /usr/share/doc/${PF}/html/java
		doins -r "${S}/"java/doc/*
		newdoc "${S}/"java/README README.java

		rm -rf "${ED}"usr/classes
		java-pkg_dojar java/turbojpeg.jar
	fi
}

multilib_src_install_all() {
	prune_libtool_files

	insinto /usr/share/doc/${PF}/html
	doins -r doc/html/*

	ebegin "Installing exifautotran and jpegexiforient extra tools"
	pushd ../debian/extra >/dev/null
	newdoc ../changelog changelog.debian

	emake \
		DESTDIR="${D}" prefix="${EPREFIX}"/usr \
		INSTALL="install -m755" INSTALLDIR="install -d -m755" \
		install
	popd >/dev/null
	eend $?
}
