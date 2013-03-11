# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.6.1.ebuild,v 1.5 2013/03/11 12:41:18 tomwij Exp $

EAPI="5"

PLOCALES="ca cs de el es fr it ja pt_BR ru sr sr@latin tr"
inherit cmake-utils eutils flag-o-matic l10n toolchain-funcs

SLOT="2.6"
MY_P="${PN}_${PV}"

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
KEYWORDS="~amd64 ~x86"
IUSE="aften a52 alsa amr debug dts fontconfig gtk jack lame libsamplerate mmx oss nls qt4 sdl -system-ffmpeg vorbis truetype xvid x264 xv"

RDEPEND="
	>=dev-lang/spidermonkey-1.5-r2
	dev-libs/libxml2
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	virtual/libiconv
	aften? ( media-libs/aften )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	amr? ( media-libs/opencore-amr )
	dts? ( media-libs/libdca )
	fontconfig? ( media-libs/fontconfig )
	gtk? ( >=x11-libs/gtk+-2.6.0:2 )
	jack? (
		media-sound/jack-audio-connection-kit
		libsamplerate? ( media-libs/libsamplerate )
	)
	lame? ( media-sound/lame )
	qt4? ( >=dev-qt/qtgui-4.8.3:4 )
	sdl? ( media-libs/libsdl )
	system-ffmpeg? ( >=media-video/ffmpeg-1.0[aac,cpudetection,mp3,theora] )
	truetype? ( >=media-libs/freetype-2.1.5 )
	x264? ( media-libs/x264 )
	xv? ( x11-libs/libXv )
	xvid? ( media-libs/xvid )
	vorbis? ( media-libs/libvorbis )
"
DEPEND="
	$RDEPEND
	oss? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"
BUILD_S="${WORKDIR}/${P}_build"

PROCESSES="buildCore:avidemux_core${POSTFIX}
		buildCli:avidemux/cli${POSTFIX}
		buildPluginsCommon:avidemux_plugins${POSTFIX}
		buildPluginsCLI:avidemux_plugins${POSTFIX}"

use qt4 && PROCESSES+=" buildQt4:avidemux/qt4${POSTFIX}
		buildPluginsQt4:avidemux_plugins${POSTFIX}"

use gtk && PROCESSES+=" buildGtk:avidemux/gtk${POSTFIX}
		buildPluginsGtk:avidemux_plugins${POSTFIX}"

src_prepare() {
	base_src_prepare

	# TODO: convert to l10n.eclass usage
	local lingua= po_files= qt_ts_files= avidemux_ts_files=
	for lingua in ${LINGUAS}; do
		if has ${lingua} ${AVIDEMUX_LANGS}; then
			if [[ -e ${S}/po/${lingua}.po ]]; then
				po_files+=" \${po_subdir}/${lingua}.po"
			fi
			if [[ -e ${S}/po/qt_${lingua}.ts ]]; then
				qt_ts_files+=" \${ts_subdir}/qt_${lingua}.ts"
			fi
			if [[ -e ${S}/po/${PN}_${lingua}.ts ]]; then
				avidemux_ts_files+=" \${ts_subdir}/${PN}_${lingua}.ts"
			fi
		fi
	done

	sed -i -e "s!FILE(GLOB po_files .*)!SET(po_files ${po_files})!" \
		"${S}/cmake/Po.cmake" || die "po_files sed failed"

	sed -i -e "s!FILE(GLOB.*qt.*)!SET(ts_files ${qt_ts_files})!" \
	    -e "s!FILE(GLOB.*avidemux.*)!SET(ts_files ${avidemux_ts_files})!" \
		"${S}/cmake/Ts.cmake" || die "ts_files sed failed"

	# Fix icon name -> avidemux-2.6.png
	sed -i -e "/^Icon/ s:${PN}:${PN}-2.6:" ${PN}2.desktop || die "Icon name fix failed."

	# The desktop file is broken. It uses avidemux2 instead of avidemux3
	# so it will actually launch avidemux-2.5 if it is installed.
	sed -i -e "/^Exec/ s:${PN}2:${PN}3:" ${PN}2.desktop || die "Desktop file fix failed."

	# Now rename the desktop file to not collide with 2.5.
	mv ${PN}2.desktop ${PN}-2.6.desktop || die "Collision rename failed."

	# Fix major issues in desktop files wrt bugs #291453, #316599, #430500
	# duplicate desktop file.
	cp ${PN}-2.6.desktop ${PN}-2.6-gtk.desktop || die "Desktop file copy failed."

	# The desktop file is broken. It uses avidemux2 instead of avidemux3
	# so it will actually launch avidemux-2.5 if it is installed.
	sed -i -re '/^Exec/ s:(avidemux3_)gtk:\1qt4:' ${PN}-2.6.desktop || die "Desktop file fix failed."

	if use system-ffmpeg ; then
		rm -rf cmake/admFFmpeg* cmake/ffmpeg* avidemux_core/ffmpeg_package buildCore/ffmpeg || die "Failed to remove ffmpeg."

		sed -i -e 's/include(admFFmpegUtil)//g' avidemux/commonCmakeApplication.cmake || die "Failed to remove ffmpeg."
		sed -i -e '/registerFFmpeg/d' avidemux/commonCmakeApplication.cmake || die "Failed to remove ffmpeg."
		sed -i -e 's/include(admFFmpegBuild)//g' avidemux_core/CMakeLists.txt || die "Failed to remove ffmpeg."
	fi
}

src_configure() {
	local x mycmakeargs plugin_ui

	mycmakeargs="
		$(for x in ${IUSE}; do cmake-utils_use ${x/#-/}; done)
		$(cmake-utils_use amr OPENCORE_AMRWB)
		$(cmake-utils_use amr OPENCORE_AMRNB)
		$(cmake-utils_use dts LIBDCA)
		$(cmake-utils_use nls GETTEXT)
		$(cmake-utils_use truetype FREETYPE2)
		$(cmake-utils_use xv XVIDEO)
	"
	use debug && POSTFIX="_debug" && mycmakeargs+="-DVERBOSE=1 -DCMAKE_BUILD_TYPE=Debug"

	for PROCESS in ${PROCESSES} ; do
		SOURCE="${PROCESS%%:*}"
		DEST="${PROCESS#*:}"

		cd "${S}" || die "Can't enter source folder."
		mkdir "${SOURCE}" || die "Can't create build folder."
		cd "${SOURCE}" || die "Can't enter build folder."

		if [[ "${SOURCE}" == "buildPluginsCommon" ]] ; then
			plugin_ui="-DPLUGIN_UI=COMMON"
		elif [[ "${SOURCE}" == "buildPluginsCLI" ]] ; then
			plugin_ui="-DPLUGIN_UI=CLI"
		elif [[ "${SOURCE}" == "buildPluginsQt4" ]] ; then
			plugin_ui="-DPLUGIN_UI=QT4"
		elif [[ "${SOURCE}" == "buildPluginsGtk" ]]; then
			plugin_ui="-DPLUGIN_UI=GTK"
		fi

		cmake -DAVIDEMUX_SOURCE_DIR="${S}" \
			-DCMAKE_INSTALL_PREFIX="/usr" \
			${mycmakeargs} ${plugin_ui} -G "Unix Makefiles" ../"${DEST}/"
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

		if [[ "${SOURCE}" == "buildCore" ]] ; then
			# TODO: Report this upstream, seems to be within ffmpeg code.
			emake -j1 CC="$(tc-getCC)" CXX="$(tc-getCXX)"
		else
			emake CC="$(tc-getCC)" CXX="$(tc-getCXX)"
		fi
	done
}

src_install() {
	for PROCESS in ${PROCESSES} ; do
		SOURCE="${PROCESS%%:*}"

		cd "${S}/${SOURCE}" || die "Can't enter build folder."

		if [[ "${SOURCE}" == "buildCore" ]] ; then
			# TODO: Report this upstream, seems to be within ffmpeg code.
			emake DESTDIR="${ED}" -j1 install
		else
			emake DESTDIR="${ED}" install
		fi
	done

	cd "${S}" || die "Can't enter source folder."

	fperms +x /usr/bin/avidemux3_cli
	fperms +x /usr/bin/avidemux3_jobs
	use gtk && fperms +x /usr/bin/avidemux3_gtk
	use qt4 && fperms +x /usr/bin/avidemux3_qt4

	newicon ${PN}_icon.png ${PN}-2.6.png
	use gtk && domenu ${PN}-2.6-gtk.desktop
	use qt4 && domenu ${PN}-2.6.desktop

	dodoc AUTHORS README
}
