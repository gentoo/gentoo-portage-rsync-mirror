# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/speech-tools/speech-tools-1.2.96_beta-r2.ebuild,v 1.6 2012/12/28 18:24:29 ulm Exp $

EAPI="2"

inherit eutils flag-o-matic multilib toolchain-funcs

MY_P=${P/speech-/speech_}
MY_P=${MY_P/_beta/-beta}

DESCRIPTION="Speech tools for Festival Text to Speech engine"
HOMEPAGE="http://www.cstr.ed.ac.uk/projects/speech_tools/"
SRC_URI="http://www.festvox.org/packed/festival/1.96/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-patches.tar.gz"

LICENSE="FESTIVAL HPND BSD rc regexp-UofT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="nas X"

DEPEND="nas? ( media-libs/nas )
	X? ( x11-libs/libX11
		x11-libs/libXt )
	!<app-accessibility/festival-1.96_beta
	!sys-power/powerman"

S="${WORKDIR}/speech_tools"

src_prepare() {
	EPATCH_SUFFIX="patch"
	epatch
	sed -i -e 's,{{HORRIBLELIBARCHKLUDGE}},"/usr/$(get_libdir)",' main/siod_main.cc
}

src_configure() {
	local CONFIG=config/config.in
	sed -i -e 's/@COMPILERTYPE@/gcc42/' ${CONFIG}
	if use nas; then
		sed -i -e "s/#.*\(INCLUDE_MODULES += NAS_AUDIO\)/\1/" ${CONFIG}
	fi
	if [ ! use X ]; then
		sed -i -e "s/-lX11 -lXt//" config/modules/esd_audio.mak
	fi
	append-ldflags $(no-as-needed)
	econf || die
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" CXX="$(tc-getCXX)" CC_OTHER_FLAGS="${CFLAGS}" \
		OPTIMISE_LINKFLAGS="${LDFLAGS}" || die "Compile failed"
}

src_install() {
	dolib.so lib/libest*.so*

	dodoc "${S}"/README
	dodoc "${S}"/lib/cstrutt.dtd

	insinto /usr/share/doc/${PF}
	doins -r lib/example_data

	insinto /usr/share/speech-tools
	doins -r config base_class

	insinto /usr/share/speech-tools/lib
	doins -r lib/siod

	cd include
	insinto /usr/include/speech-tools
	doins -r *
	dosym /usr/include/speech-tools /usr/share/speech-tools/include

	cd ../bin
	for file in *; do
		[ "${file}" = "Makefile" ] && continue
		dobin ${file}
		dstfile="${D}/usr/bin/${file}"
		sed -i -e "s:${S}/testsuite/data:/usr/share/speech-tools/testsuite:g" ${dstfile}
		sed -i -e "s:${S}/bin:/usr/$(get_libdir)/speech-tools:g" ${dstfile}
		sed -i -e "s:${S}/main:/usr/$(get_libdir)/speech-tools:g" ${dstfile}

		# This just changes LD_LIBRARY_PATH
		sed -i -e "s:${S}/lib:/usr/$(get_libdir):g" ${dstfile}
	done

	cd "${S}"
	exeinto /usr/$(get_libdir)/speech-tools
	for file in `find main -perm +100 -type f`; do
		doexe ${file}
	done

	#Rename to avoid file collisions. See bug #287983
	mv "${D}/usr/bin/dp" "${D}/usr/bin/speech-dp"
	#Remove /usr/bin/resynth as it is broken. See bug #253556
	rm "${D}/usr/bin/resynth"
}

pkg_postinst() {
	elog "The /usr/bin/dp wrapper script has been renamed to /usr/bin/speech-dp"
	elog "due to file collision with other programs."
	elog "See bug #287983 for more details"

	elog "The /usr/bin/resynth program has been removed since it is broken"
	elog "See bug #253556 for more details"
}
