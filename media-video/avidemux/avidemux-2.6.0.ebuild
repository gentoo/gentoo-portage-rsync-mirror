# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.6.0.ebuild,v 1.2 2013/03/02 22:06:56 hwoarang Exp $

EAPI=4
PLOCALES="ca cs de el es fr it ja pt_BR ru sr sr@latin tr"
inherit cmake-utils eutils flag-o-matic l10n toolchain-funcs

MY_P=${PN}_${PV}

DESCRIPTION="Video editor designed for simple cutting, filtering and encoding tasks"
HOMEPAGE="http://fixounet.free.fr/avidemux"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${MY_P}.tar.gz"

# Multiple licenses because of all the bundled stuff
LICENSE="GPL-2 MIT GPL-1 public-domain PSF-2"
SLOT="2.6"
KEYWORDS="~amd64 ~x86"
IUSE="aften a52 alsa amr debug dts fontconfig gtk jack
	lame libsamplerate mmx nls qt4 sdl vorbis truetype xvid xv oss x264"

RDEPEND="
	virtual/libiconv
	dev-libs/libxml2
	media-libs/libpng
	>=dev-lang/spidermonkey-1.5-r2
	gtk? ( >=x11-libs/gtk+-2.6.0:2 )
	qt4? ( >=dev-qt/qtgui-4.8.3:4 )
	x264? ( media-libs/x264 )
	xvid? ( media-libs/xvid )
	aften? ( media-libs/aften )
	amr? ( media-libs/opencore-amr )
	lame? ( media-sound/lame )
	dts? ( media-libs/libdca )
	vorbis? ( media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-1.0.3b-r2 )
	jack? (
		media-sound/jack-audio-connection-kit
		libsamplerate? ( media-libs/libsamplerate )
	)
	truetype? ( >=media-libs/freetype-2.1.5 )
	fontconfig? ( media-libs/fontconfig )
	sdl? ( media-libs/libsdl )
	xv? ( x11-libs/libXv )
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
"
DEPEND="
	$RDEPEND
	oss? ( virtual/os-headers )
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
"
S=${WORKDIR}/${MY_P}
BUILD_S=${WORKDIR}/${P}_build

avidemux_build_process() {
	local BUILDDIR="${1}"
	local SOURCEDIR="${2}"
	local mycmakeargs="${3}"
	EXTRA="${mycmakeargs}"
	BUILDER="Unix Makefiles"
	FAKEROOT_DIR="${S}"/gentoo-install
	SOURCEDIR="${2}"
	mkdir ${BUILDDIR} && cd "${BUILDDIR}"
	einfo "Configuring: ${BUILDDIR}"
	cmake -DFAKEROOT="${FAKEROOT_DIR}" -DAVIDEMUX_SOURCE_DIR="${S}" \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		${EXTRA} -G "${BUILDER}" ../"${SOURCEDIR}/"
	# for some reason, core needs -j1. That's what they do in their
	# script as well
	if [[ ${BUILDDIR} == "buildCore" ]]; then
		extra_opts="-j1"
	else
		unset extra_opts
	fi
	einfo "Building: ${BUILDDIR}"
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" ${extra_opts}

	einfo "Fake install: ${BUILDDIR}"
	# pretend that you installed it somewhere
	emake DESTDIR="${FAKEROOT_DIR}" ${extra_opts} install

	cd ..
}

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
		"${S}/cmake/Po.cmake" || die "sed failed"
	sed -i -e "s!FILE(GLOB.*qt.*)!SET(ts_files ${qt_ts_files})!" \
	    -e "s!FILE(GLOB.*avidemux.*)!SET(ts_files ${avidemux_ts_files})!" \
		"${S}/cmake/Ts.cmake" || die "sed failed"

	# Fix icon name -> avidemux-2.6.png
	sed -i -e "/^Icon/ s:${PN}:${PN}-2.6:" ${PN}2.desktop || die
	# the desktop file is broken. It uses avidemux2 instead of avidemux3
	# so it will actually launch avidemux-2.5 if it is installed
	sed -i -e "/^Exec/ s:${PN}2:${PN}3:" ${PN}2.desktop || die
	# Now rename to not collide with 2.5
	mv ${PN}2.desktop ${PN}-2.6.desktop
	# fix major issues in desktop files wrt bugs #291453, #316599, #430500
	# duplicate desktop file
	cp ${PN}-2.6.desktop ${PN}-2.6-gtk.desktop || die
	# the desktop file is broken. It uses avidemux2 instead of avidemux3
	# so it will actually launch avidemux-2.5 if it is installed
	sed -i -re '/^Exec/ s:(avidemux3_)gtk:\1qt4:' ${PN}-2.6.desktop || die
}

src_configure() {
	true;
}

src_compile() {
	# add lax vector typing for PowerPC
	if use ppc || use ppc64; then
		append-cflags -flax-vector-conversions
	fi
	# bug 432322
	use x86 && replace-flags -O0 -O1

	local x mycmakeargs
	# default args
	use debug \
		&& POSTFIX="_debug" \
		&& mycmakeargs+="-DVERBOSE=1 -DCMAKE_BUILD_TYPE=Debug"

	mycmakeargs="
		$(for x in ${IUSE}; do cmake-utils_use $x; done)
		$(cmake-utils_use dts LIBDCA)
		$(cmake-utils_use truetype FREETYPE2)
		$(cmake-utils_use nls GETTEXT)
		$(cmake-utils_use xv XVIDEO)
		$(cmake-utils_use amr OPENCORE_AMRWB)
		$(cmake-utils_use amr OPENCORE_AMRNB)
	"

	# Lets try to do all the s**t that bootStrap.bash is
	# trying to do
	use qt4 && with_qt4=1
	use gtk && with_gtk=1

	avidemux_build_process buildCore avidemux_core${POSTFIX} "${mycmakeargs}"
	avidemux_build_process buildCli avidemux/cli${POSTFIX} "${mycmakeargs}"
	mycmakeargs+="-DPLUGIN_UI=COMMON "
	avidemux_build_process buildPluginsCommon avidemux_plugins${POSTFIX} "${mycmakeargs}"
	mycmakeargs+="-DPLUGIN_UI=CLI "
	avidemux_build_process buildPluginsCLI avidemux_plugins${POSTFIX} "${mycmakeargs}"

	if use qt4; then
		avidemux_build_process buildQt4 avidemux/qt4${POSTFIX} "${mycmakeargs}"
		mycmakeargs+="-DPLUGIN_UI=QT4 "
		avidemux_build_process buildPluginsQt4 avidemux_plugins${POSTFIX} "${mycmakeargs}"
	fi
	if use gtk; then
		avidemux_build_process buildGtk avidemux/gtk${POSTFIX} "${mycmakeargs}"
		mycmakeargs+="-DPLUGIN_UI=GTK "
		avidemux_build_process buildPluginsGtk avidemux_plugins${POSTFIX} "${mycmakeargs}"
	fi
}

src_install() {
	# everything is installed(?) in ${S}/gentoo-install.
	# Move it to ${D}.
	insinto /
	doins -r "${S}"/gentoo-install/*
	# Mark executables with +x
	find "${ED}"/usr/bin -exec chmod a+x {} \;

	newicon ${PN}_icon.png ${PN}-2.6.png
	use gtk && domenu ${PN}-2.6-gtk.desktop
	use qt4 && domenu ${PN}-2.6.desktop
	dodoc AUTHORS README
}
