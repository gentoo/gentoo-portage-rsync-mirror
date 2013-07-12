# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/avidemux-plugins/avidemux-plugins-2.6.4-r1.ebuild,v 1.1 2013/07/12 18:53:50 tomwij Exp $

EAPI="5"

PLOCALES="ca cs de el es fr it ja pt_BR ru sr sr@latin tr"
inherit cmake-utils eutils flag-o-matic l10n toolchain-funcs

SLOT="2.6"
MY_PN="${PN/-plugins/}"
MY_P="${MY_PN}_${PV}"

DESCRIPTION="Plugins for avidemux; a video editor designed for simple cutting, filtering and encoding tasks."
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${MY_PN}/${PV}/${MY_P}.tar.gz"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
KEYWORDS="~amd64 ~x86"
IUSE="aften a52 alsa amr debug dts faac faad fontconfig freetype2 fribidi jack lame libsamplerate mmx opengl oss pulseaudio qt4 vorbis truetype twolame xvid x264 vpx"

DEPEND="
	=media-video/avidemux-${PV}[opengl?,qt4?]
	>=dev-lang/spidermonkey-1.5-r2
	dev-libs/libxml2
	media-libs/libpng
	virtual/libiconv
	aften? ( media-libs/aften )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	amr? ( media-libs/opencore-amr )
	dts? ( media-libs/libdca )
	faac? ( media-libs/faac )
	faad? ( media-libs/faad2 )
	fontconfig? ( media-libs/fontconfig )
	freetype2? ( media-libs/freetype:2 )
	fribidi? ( dev-libs/fribidi )
	jack? (
		media-sound/jack-audio-connection-kit
		libsamplerate? ( media-libs/libsamplerate )
	)
	lame? ( media-sound/lame )
	oss? ( virtual/os-headers )
	pulseaudio? ( media-sound/pulseaudio )
	truetype? ( >=media-libs/freetype-2.1.5 )
	twolame? ( media-sound/twolame )
	x264? ( media-libs/x264:= )
	xvid? ( media-libs/xvid )
	vorbis? ( media-libs/libvorbis )
	vpx? ( media-libs/libvpx )
"
RDEPEND="$DEPEND"

S="${WORKDIR}/${MY_P}"

PROCESSES="buildPluginsCommon:avidemux_plugins
	buildPluginsCLI:avidemux_plugins"

use qt4 && PROCESSES+=" buildPluginsQt4:avidemux_plugins"

src_prepare() {
	epatch "${FILESDIR}"/${P}-optional-pulse.patch
}

src_configure() {
	local x mycmakeargs plugin_ui

	mycmakeargs="
		$(cmake-utils_use alsa ALSA)
		$(cmake-utils_use aften AFTEN)
		$(cmake-utils_use amr OPENCORE_AMRWB)
		$(cmake-utils_use amr OPENCORE_AMRNB)
		$(cmake-utils_use dts LIBDCA)
		$(cmake-utils_use faad FAAC)
		$(cmake-utils_use faad FAAD)
		$(cmake-utils_use fontconfig FONTCONFIG)
		$(cmake-utils_use freetype2 FREETYPE2)
		$(cmake-utils_use jack JACK)
		$(cmake-utils_use lame LAME)
		$(cmake-utils_use oss OSS)
		$(cmake-utils_use pulseaudio PULSEAUDIOSIMPLE)
		$(cmake-utils_use qt4 QT4)
		$(cmake-utils_use truetype FREETYPE2)
		$(cmake-utils_use twolame TWOLAME)
		$(cmake-utils_use x264 X264)
		$(cmake-utils_use xvid XVID)
		$(cmake-utils_use xvid XVIDEO)
		$(cmake-utils_use vorbis VORBIS)
		$(cmake-utils_use vorbis LIBVORBIS)
		$(cmake-utils_use vpx VPXDEC)
	"

	use debug && POSTFIX="_debug" && mycmakeargs+="-DVERBOSE=1 -DCMAKE_BUILD_TYPE=Debug"

	for PROCESS in ${PROCESSES} ; do
		SOURCE="${PROCESS%%:*}"
		DEST="${PROCESS#*:}"

		mkdir "${S}"/${SOURCE} || die "Can't create build folder."
		cd "${S}"/${SOURCE} || die "Can't enter build folder."

		if [[ "${SOURCE}" == "buildPluginsCommon" ]] ; then
			plugin_ui="-DPLUGIN_UI=COMMON"
		elif [[ "${SOURCE}" == "buildPluginsCLI" ]] ; then
			plugin_ui="-DPLUGIN_UI=CLI"
		elif [[ "${SOURCE}" == "buildPluginsQt4" ]] ; then
			plugin_ui="-DPLUGIN_UI=QT4"
		fi

		cmake -DAVIDEMUX_SOURCE_DIR="${S}" \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			${mycmakeargs} ${plugin_ui} -G "Unix Makefiles" ../"${DEST}${POSTFIX}/" || die "cmake failed."
	done
}

src_compile() {
	# Add lax vector typing for PowerPC.
	if use ppc || use ppc64 ; then
		append-cflags -flax-vector-conversions
	fi

	# See bug 432322.
	use x86 && replace-flags -O0 -O1

	for PROCESS in ${PROCESSES} ; do
		SOURCE="${PROCESS%%:*}"

		cd "${S}/${SOURCE}" || die "Can't enter build folder."
		emake CC="$(tc-getCC)" CXX="$(tc-getCXX)"
	done
}

src_install() {
	for PROCESS in ${PROCESSES} ; do
		SOURCE="${PROCESS%%:*}"

		cd "${S}/${SOURCE}" || die "Can't enter build folder."
		emake DESTDIR="${ED}" install
	done
}
