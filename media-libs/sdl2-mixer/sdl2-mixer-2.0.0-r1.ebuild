# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/sdl2-mixer/sdl2-mixer-2.0.0-r1.ebuild,v 1.1 2014/05/03 10:25:47 mgorny Exp $

EAPI=5
inherit eutils multilib-minimal

MY_P=SDL2_mixer-${PV}
DESCRIPTION="Simple Direct Media Layer Mixer Library"
HOMEPAGE="http://www.libsdl.org/projects/SDL_mixer/"
SRC_URI="http://www.libsdl.org/projects/SDL_mixer/release/${MY_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="flac fluidsynth mad midi mikmod mod modplug mp3 playtools smpeg static-libs timidity tremor vorbis +wav"
REQUIRED_USE="
	midi? ( || ( timidity fluidsynth ) )
	timidity? ( midi )
	fluidsynth? ( midi )
	mp3? ( || ( smpeg mad ) )
	smpeg? ( mp3 )
	mad? ( mp3 )
	mod? ( || ( mikmod modplug ) )
	mikmod? ( mod )
	modplug? ( mod )
	tremor? ( vorbis )
	"

RDEPEND="media-libs/libsdl2[${MULTILIB_USEDEP}]
	flac? ( media-libs/flac[${MULTILIB_USEDEP}] )
	midi? (
		fluidsynth? ( media-sound/fluidsynth[${MULTILIB_USEDEP}] )
		timidity? ( media-sound/timidity++ )
	)
	mp3? (
		mad? ( media-libs/libmad[${MULTILIB_USEDEP}] )
		smpeg? ( media-libs/smpeg2[${MULTILIB_USEDEP}] )
	)
	mod? (
		modplug? ( media-libs/libmodplug[${MULTILIB_USEDEP}] )
		mikmod? ( media-libs/libmikmod[${MULTILIB_USEDEP}] )
	)
	vorbis? (
		tremor? ( media-libs/tremor[${MULTILIB_USEDEP}] )
		!tremor? (
			media-libs/libvorbis[${MULTILIB_USEDEP}]
			media-libs/libogg[${MULTILIB_USEDEP}] )
	)"
DEPEND=${RDEPEND}

S=${WORKDIR}/${MY_P}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		$(use_enable static-libs static) \
		--disable-sdltest \
		--enable-music-cmd \
		$(use_enable wav music-wave) \
		$(use_enable mod music-mod) \
		$(use_enable modplug music-mod-modplug) \
		--disable-music-mod-modplug-shared \
		$(use_enable mikmod music-mod-mikmod) \
		--disable-music-mod-mikmod-shared \
		$(use_enable midi music-midi) \
		$(use_enable timidity music-midi-timidity) \
		$(use_enable fluidsynth music-midi-fluidsynth) \
		--disable-music-fluidsynth-shared \
		$(use_enable vorbis music-ogg) \
		$(use_enable tremor music-ogg-tremor) \
		--disable-music-ogg-shared \
		$(use_enable flac music-flac) \
		--disable-music-flac-shared \
		$(use_enable mp3 music-mp3) \
		$(use_enable smpeg music-mp3-smpeg) \
		--disable-music-mp3-smpeg-shared \
		--disable-smpegtest \
		$(use_enable mad music-mp3-mad-gpl)
}

multilib_src_install() {
	emake DESTDIR="${D}" install
	if multilib_is_native_abi && use playtools; then
		emake DESTDIR="${D}" install-bin
	fi
}

multilib_src_install_all() {
	dodoc {CHANGES,README}.txt
	use static-libs || prune_libtool_files
}

pkg_postinst() {
	# bug 412035
	# https://bugs.gentoo.org/show_bug.cgi?id=412035
	if use midi ; then
		if use fluidsynth; then
			ewarn "FluidSynth support requires you to set the SDL_SOUNDFONTS"
			ewarn "environment variable to the location of a SoundFont file"
			ewarn "unless the game or application happens to do this for you."

			if use timidity; then
				ewarn "Failing to do so will result in Timidity being used instead."
			else
				ewarn "Failing to do so will result in silence."
			fi
		fi
	fi
}
