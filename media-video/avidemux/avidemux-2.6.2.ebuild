# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.6.2.ebuild,v 1.3 2013/03/17 14:22:55 tomwij Exp $

EAPI="5"

PLOCALES="ca cs de el es fr it ja pt_BR ru sr sr@latin tr"
inherit cmake-utils eutils flag-o-matic l10n toolchain-funcs

SLOT="2.6"
MY_P="${PN}_${PV}"

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks."
HOMEPAGE="http://fixounet.free.fr/${PN}"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
KEYWORDS="~amd64 ~x86"
IUSE="aften a52 alsa amr debug dts fontconfig gtk jack lame libsamplerate mmx oss nls qt4 sdl vorbis truetype xvid x264 xv"

# TODO: Figure out which dependencies can be moved out of avidemux-core into here.
RDEPEND="=media-libs/avidemux-core-${PV}[aften?,a52?,alsa?,amr?,dts?,fontconfig?,jack?,lame?,libsamplerate?,mmx?,oss?,nls?,sdl?,vorbis?,truetype?,xvid?,x264?,xv?]
	gtk? ( >=x11-libs/gtk+-2.6.0:2 )
	qt4? ( >=dev-qt/qtgui-4.8.3:4 )"
DEPEND="$RDEPEND"

S="${WORKDIR}/${MY_P}"

PROCESSES="buildCli:avidemux/cli
	buildPluginsCommon:avidemux_plugins
	buildPluginsCLI:avidemux_plugins"

use qt4 && PROCESSES+=" buildQt4:avidemux/qt4
	buildPluginsQt4:avidemux_plugins"

use gtk && PROCESSES+=" buildGtk:avidemux/gtk
	buildPluginsGtk:avidemux_plugins"

src_prepare() {
	base_src_prepare

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

	# Fix QA warnings that complain a trailing ; is missing and Application is deprecated.
	sed -i -e 's/Application;AudioVideo/AudioVideo;/g' ${PN}-2.6.desktop
	sed -i -e 's/Application;AudioVideo/AudioVideo;/g' ${PN}-2.6-gtk.desktop

	# Force the config checks to pass.
	epatch "${FILESDIR}"/avidemux-2.6.2-config-h.patch
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

		mkdir "${S}"/${SOURCE} || die "Can't create build folder."
		cd "${S}"/${SOURCE} || die "Can't enter build folder."

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
		if [[ "${SOURCE}" == "buildPluginsCLI" || "${SOURCE}" == "buildPluginsQt4" || "${SOURCE}" == "buildPluginsGtk" ]] ; then
			emake DESTDIR="${ED}" preinstall
		else
			emake DESTDIR="${ED}" install
		fi
	done

	cd "${S}" || die "Can't enter source folder."

	if [[ -f "${ED}"/usr/bin/avidemux3_cli ]] ; then
		fperms +x /usr/bin/avidemux3_cli
	fi

	if [[ -f "${ED}"/usr/bin/avidemux3_jobs ]] ; then
		fperms +x /usr/bin/avidemux3_jobs
	fi
	use gtk && fperms +x /usr/bin/avidemux3_gtk
	use qt4 && fperms +x /usr/bin/avidemux3_qt4

	newicon ${PN}_icon.png ${PN}-2.6.png
	use gtk && domenu ${PN}-2.6-gtk.desktop
	use qt4 && domenu ${PN}-2.6.desktop

	dodoc AUTHORS README
}
