# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-tools/speech-tools-1.2.96_beta.ebuild,v 1.17 2012/12/28 18:24:29 ulm Exp $

inherit eutils multilib toolchain-funcs

MY_P=${P/speech-/speech_}
MY_P=${MY_P/_beta/-beta}

DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/projects/speech_tools/"
SRC_URI="http://www.festvox.org/packed/festival/latest/${MY_P}.tar.gz"

LICENSE="FESTIVAL HPND BSD rc regexp-UofT"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="nas X"

RDEPEND="nas? ( media-libs/nas )
	X? ( x11-libs/libX11
		x11-libs/libXt )
	!<app-accessibility/festival-1.96_beta
	!sys-power/powerman"
DEPEND="${RDEPEND}"

S=${WORKDIR}/speech_tools

src_unpack() {
	local CONFIG=${S}/config/config.in
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-gcc43-include.patch \
		"${FILESDIR}"/${P}-gcc44.patch

# set compiler flags for base_class
	sed -i -e "s:-O3:\$(OPTIMISE_CXXFLAGS):" "${S}"/base_class/Makefile

	# enable building shared libraries
	sed -i -e "s/#.*\(SHARED=2\)/\1/" ${CONFIG}

	use nas && sed -i -e "s/#.*\(INCLUDE_MODULES += NAS_AUDIO\)/\1/" ${CONFIG}
	use X || sed -i -e "s/-lX11 -lXt//" "${S}"/config/modules/esd_audio.mak
}

src_compile() {
	econf || die
	emake -j1 OPTIMISE_CXXFLAGS="${CXXFLAGS}" OPTIMISE_CCFLAGS="${CFLAGS}" CC="$(tc-getCC)" CXX="$(tc-getCXX)" || die
}

src_install() {
	dolib.so lib/libest*.so.1*
	dosym libestbase.so.1.2.96.1 /usr/$(get_libdir)/libestbase.so
	dosym libestools.so.1.2.96.1 /usr/$(get_libdir)/libestools.so
	dosym libeststring.so.1.2 /usr/$(get_libdir)/libeststring.so
	dolib.a lib/{libestbase.a,libestools.a,libeststring.a}

	cd bin
	for file in *; do
		[ "${file}" = "Makefile" ] && continue
		dobin ${file}
		dstfile="/usr/bin/${file}"
		dosed "s:${S}/testsuite/data:/usr/share/speech-tools/testsuite:g" ${dstfile}
		dosed "s:${S}/bin:/usr/$(get_libdir)/speech-tools:g" ${dstfile}
		dosed "s:${S}/main:/usr/$(get_libdir)/speech-tools:g" ${dstfile}

		# This just changes LD_LIBRARY_PATH
		dosed "s:${S}/lib:/usr/$(get_libdir):g" ${dstfile}
	done

	cd "${S}"
	exeinto /usr/$(get_libdir)/speech-tools
	for file in `find main -perm +100 -type f`; do
		doexe ${file}
	done

	insinto /usr/share/speech-tools
	doins -r config

	insinto /usr/share/speech-tools/lib
	doins -r lib/siod

	insinto /usr/share/doc/${PF}
	doins -r lib/example_data

	cd include
	insinto /usr/include/speech-tools
	doins -r *
	dosym /usr/include/speech-tools /usr/share/speech-tools/include
	cd "${S}"

	dodoc "${S}"/README
	dodoc "${S}"/lib/cstrutt.dtd
}
