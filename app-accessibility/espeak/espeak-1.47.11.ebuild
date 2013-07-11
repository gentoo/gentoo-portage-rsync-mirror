# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.47.11.ebuild,v 1.1 2013/07/11 05:14:31 williamh Exp $

EAPI=5

inherit eutils multilib toolchain-funcs

MY_P="${P}-source"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="portaudio pulseaudio"
RDEPEND="media-sound/sox
	pulseaudio? ( media-sound/pulseaudio )
	portaudio? ( >=media-libs/portaudio-19_pre20071207 )"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

get_audio() {
	if use portaudio && use pulseaudio; then
		echo runtime
	elif use portaudio; then
		echo portaudio
	elif use pulseaudio; then
		echo pulseaudio
	else
		echo none
	fi
}

src_prepare() {
	cd src
	# gentoo uses portaudio 19.
	mv -f portaudio19.h portaudio.h
}

src_compile() {
	cd src
	emake PREFIX="${EPREFIX}/usr" AUDIO="$(get_audio)" \
	CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" all

	einfo "Fixing byte order of phoneme data files"
	cd "${S}/platforms/big_endian"
	make
	./espeak-phoneme-data "${S}/espeak-data"
	cp -f phondata phonindex phontab "${S}/espeak-data"
}

src_install() {
	cd src
	make DESTDIR="${D}" PREFIX="${EPREFIX}/usr" LIBDIR="\$(PREFIX)/$(get_libdir)" AUDIO="$(get_audio)" install

	cd ..
	insinto /usr/share/espeak-data
	doins -r dictsource
	dodoc ChangeLog.txt ReadMe
	dohtml -r docs/*
}

pkg_preinst() {
	local voicedir="${ROOT}/usr/share/${PN}-data/voices/en"
	local errormsg="${voicedir} not empty.  Please remove it manually."
	if [ -d "${voicedir}" ]; then
		rmdir "${voicedir}" || die "${errormsg}"
	fi
}

pkg_postinst() {
	if ! use portaudio && ! use pulseaudio; then
		ewarn "Since portaudio and pulseaudio are not in your use flags,"
		ewarn "espeak will only be able to create wav files."
		ewarn "If this is not what you want, please reemerge ${CATEGORY}/${PN}"
		ewarn "with either portaudio or pulseaudio USE flag enabled."
	fi
}
