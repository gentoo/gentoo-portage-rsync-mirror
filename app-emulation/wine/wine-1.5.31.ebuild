# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-1.5.31.ebuild,v 1.1 2013/05/26 04:27:24 tetromino Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1
PLOCALES="ar bg ca cs da de el en en_US eo es fa fi fr he hi hu it ja ko lt ml nb_NO nl or pa pl pt_BR pt_PT rm ro ru sk sl sr_RS@cyrillic sr_RS@latin sv te th tr uk wa zh_CN zh_TW"
PLOCALE_BACKUP="en"

inherit autotools-multilib eutils flag-o-matic gnome2-utils l10n multilib pax-utils toolchain-funcs virtualx

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://source.winehq.org/git/wine.git"
	inherit git-2
	SRC_URI=""
	#KEYWORDS=""
else
	MY_P="${PN}-${PV/_/-}"
	SRC_URI="mirror://sourceforge/${PN}/Source/${MY_P}.tar.bz2"
	KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
	S=${WORKDIR}/${MY_P}
fi

GV="2.21"
MV="0.0.8"
PULSE_PATCHES="winepulse-patches-1.5.30"
WINE_GENTOO="wine-gentoo-2012.11.24"
DESCRIPTION="Free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.winehq.org/"
SRC_URI="${SRC_URI}
	gecko? (
		abi_x86_32? ( mirror://sourceforge/${PN}/Wine%20Gecko/${GV}/wine_gecko-${GV}-x86.msi )
		abi_x86_64? ( mirror://sourceforge/${PN}/Wine%20Gecko/${GV}/wine_gecko-${GV}-x86_64.msi )
	)
	mono? ( mirror://sourceforge/${PN}/Wine%20Mono/${MV}/wine-mono-${MV}.msi )
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${PULSE_PATCHES}.tar.bz2
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${WINE_GENTOO}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+abi_x86_32 +abi_x86_64 alsa capi cups custom-cflags elibc_glibc fontconfig +gecko gphoto2 gsm gstreamer jpeg lcms ldap +mono mp3 ncurses nls odbc openal opencl +opengl osmesa +oss +perl png +prelink samba scanner selinux ssl test +threads +truetype udisks v4l +X xcomposite xinerama xml"
[[ ${PV} == "9999" ]] || IUSE="${IUSE} pulseaudio"
REQUIRED_USE="|| ( abi_x86_32 abi_x86_64 )
	test? ( abi_x86_32 )
	elibc_glibc? ( threads )
	mono? ( abi_x86_32 )
	osmesa? ( opengl )" #286560

# FIXME: the test suite is unsuitable for us; many tests require net access
# or fail due to Xvfb's opengl limitations.
RESTRICT="test"

RDEPEND="truetype? ( >=media-libs/freetype-2.0.0 media-fonts/corefonts )
	perl? ( dev-lang/perl dev-perl/XML-Simple )
	capi? ( net-dialup/capi4k-utils )
	ncurses? ( >=sys-libs/ncurses-5.2:= )
	fontconfig? ( media-libs/fontconfig:= )
	gphoto2? ( media-libs/libgphoto2:= )
	openal? ( media-libs/openal:= )
	udisks? (
		sys-apps/dbus
		sys-fs/udisks:2
	)
	gstreamer? ( media-libs/gstreamer:0.10 media-libs/gst-plugins-base:0.10 )
	X? (
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXxf86vm
	)
	xinerama? ( x11-libs/libXinerama )
	alsa? ( media-libs/alsa-lib )
	cups? ( net-print/cups:= )
	opencl? ( virtual/opencl )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	gsm? ( media-sound/gsm:= )
	jpeg? ( virtual/jpeg:= )
	ldap? ( net-nds/openldap:= )
	lcms? ( media-libs/lcms:0= )
	mp3? ( >=media-sound/mpg123-1.5.0 )
	nls? ( sys-devel/gettext )
	odbc? ( dev-db/unixODBC:= )
	osmesa? ( media-libs/mesa[osmesa] )
	samba? ( >=net-fs/samba-3.0.25 )
	selinux? ( sec-policy/selinux-wine )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	scanner? ( media-gfx/sane-backends:= )
	ssl? ( net-libs/gnutls:= )
	png? ( media-libs/libpng:0= )
	v4l? ( media-libs/libv4l )
	xcomposite? ( x11-libs/libXcomposite )
	amd64? (
		abi_x86_32? (
			gstreamer? (
				app-emulation/emul-linux-x86-gstplugins
				app-emulation/emul-linux-x86-medialibs[development]
			)
			truetype? ( >=app-emulation/emul-linux-x86-xlibs-2.1[development] )
			X? (
				>=app-emulation/emul-linux-x86-xlibs-2.1[development]
				>=app-emulation/emul-linux-x86-soundlibs-2.1[development]
			)
			mp3? ( app-emulation/emul-linux-x86-soundlibs[development] )
			odbc? ( app-emulation/emul-linux-x86-db[development] )
			openal? ( app-emulation/emul-linux-x86-sdl[development] )
			opengl? ( app-emulation/emul-linux-x86-opengl[development] )
			osmesa? ( >=app-emulation/emul-linux-x86-opengl-20121028[development] )
			scanner? ( app-emulation/emul-linux-x86-medialibs[development] )
			v4l? ( app-emulation/emul-linux-x86-medialibs[development] )
			>=app-emulation/emul-linux-x86-baselibs-20130224[development]
			>=sys-kernel/linux-headers-2.6
		)
	)"
[[ ${PV} == "9999" ]] || RDEPEND="${RDEPEND}
	pulseaudio? (
		media-sound/pulseaudio
		sys-auth/rtkit
	)"
DEPEND="${RDEPEND}
	X? (
		x11-proto/inputproto
		x11-proto/xextproto
		x11-proto/xf86vidmodeproto
	)
	xinerama? ( x11-proto/xineramaproto )
	prelink? ( sys-devel/prelink )
	virtual/pkgconfig
	virtual/yacc
	sys-devel/flex"

# These use a non-standard "Wine" category, which is provided by
# /etc/xdg/applications-merged/wine.menu
QA_DESKTOP_FILE="usr/share/applications/wine-browsedrive.desktop
usr/share/applications/wine-notepad.desktop
usr/share/applications/wine-uninstaller.desktop
usr/share/applications/wine-winecfg.desktop"

src_unpack() {
	if use abi_x86_64; then
		[[ $(( $(gcc-major-version) * 100 + $(gcc-minor-version) )) -lt 404 ]] \
			&& die "you need gcc-4.4+ to build 64bit wine"
	fi

	if use abi_x86_32 && use opencl; then
		[[ x$(eselect opencl show) = "xintel" ]] &&
			die "Cannot build wine[opencl,abi_x86_32]: intel-ocl-sdk is 64-bit only" # 403947
	fi

	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${MY_P}.tar.bz2
	fi

	unpack "${PULSE_PATCHES}.tar.bz2"
	unpack "${WINE_GENTOO}.tar.bz2"

	l10n_find_plocales_changes "${S}/po" "" ".po"
}

src_prepare() {
	local md5="$(md5sum server/protocol.def)"
	local PATCHES=(
		"${FILESDIR}"/${PN}-1.5.26-winegcc.patch #260726
		"${FILESDIR}"/${PN}-1.4_rc2-multilib-portage.patch #395615
		"${FILESDIR}"/${PN}-1.5.17-osmesa-check.patch #429386
		"${FILESDIR}"/${PN}-1.5.23-winebuild-CCAS.patch #455308
		"${FILESDIR}"/${PN}-1.5.31-gnutls-3.2.0.patch #http://bugs.winehq.org/show_bug.cgi?id=33649
	)
	[[ ${PV} == "9999" ]] || PATCHES+=(
		"../${PULSE_PATCHES}"/*.patch #421365
	)

	autotools-utils_src_prepare

	if [[ "$(md5sum server/protocol.def)" != "${md5}" ]]; then
		einfo "server/protocol.def was patched; running tools/make_requests"
		tools/make_requests || die #432348
	fi
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in || die
	sed -i '/^MimeType/d' tools/wine.desktop || die #117785

	l10n_get_locales > po/LINGUAS # otherwise wine doesn't respect LINGUAS
}

do_configure() {
	local myeconfargs=(
		"${myeconfargs[@]}"
		CCAS="$(tc-getAS)"
	)

	if use amd64; then
		if [[ ${ABI} == amd64 ]]; then
			myeconfargs+=( --enable-win64 )
		else
			myeconfargs+=( --disable-win64 )
		fi

		# Note: using --with-wine64 results in problems with multilib.eclass
		# CC/LD hackery. We're using separate tools instead.
	fi

	autotools-utils_src_configure
}

src_configure() {
	export LDCONFIG=/bin/true
	use custom-cflags || strip-flags

	local myeconfargs=( # common
		--sysconfdir=/etc/wine
		$(use_with alsa)
		$(use_with capi)
		$(use_with lcms cms)
		$(use_with cups)
		$(use_with ncurses curses)
		$(use_with udisks dbus)
		$(use_with fontconfig)
		$(use_with ssl gnutls)
		$(use_with gphoto2 gphoto)
		$(use_with gsm)
		$(use_with gstreamer)
		--without-hal
		$(use_with jpeg)
		$(use_with ldap)
		$(use_with mp3 mpg123)
		$(use_with nls gettext)
		$(use_with openal)
		$(use_with opencl)
		$(use_with opengl)
		$(use_with osmesa)
		$(use_with oss)
		$(use_with png)
		$(use_with threads pthread)
		$(use_with scanner sane)
		$(use_enable test tests)
		$(use_with truetype freetype)
		$(use_with v4l)
		$(use_with X x)
		$(use_with xcomposite)
		$(use_with xinerama)
		$(use_with xml)
		$(use_with xml xslt)
	)

	[[ ${PV} == "9999" ]] || myeconfargs+=( $(use_with pulseaudio pulse) )

	multilib_parallel_foreach_abi do_configure
}

src_compile() {
	autotools-multilib_src_compile depend
	autotools-multilib_src_compile all
}

src_test() {
	if [[ $(id -u) == 0 ]]; then
		ewarn "Skipping tests since they cannot be run under the root user."
		ewarn "To run the test ${PN} suite, add userpriv to FEATURES in make.conf"
		return
	fi

	# FIXME: win32-only; wine64 tests fail with "could not find the Wine loader"
	multilib_toolchain_setup x86
	local BUILD_DIR="${S}-${ABI}"
	cd "${BUILD_DIR}" || die
	WINEPREFIX="${T}/.wine-${ABI}" Xemake test
}

src_install() {
	local DOCS=( ANNOUNCE AUTHORS README )
	autotools-multilib_src_install

	emake -C "../${WINE_GENTOO}" install DESTDIR="${D}" EPREFIX="${EPREFIX}"
	if use gecko ; then
		insinto /usr/share/wine/gecko
		use abi_x86_32 && doins "${DISTDIR}"/wine_gecko-${GV}-x86.msi
		use abi_x86_64 && doins "${DISTDIR}"/wine_gecko-${GV}-x86_64.msi
	fi
	if use mono ; then
		insinto /usr/share/wine/mono
		doins "${DISTDIR}"/wine-mono-${MV}.msi
	fi
	if ! use perl ; then
		rm "${D}"usr/bin/{wine{dump,maker},function_grep.pl} "${D}"usr/share/man/man1/wine{dump,maker}.1 || die
	fi

	use abi_x86_32 && pax-mark psmr "${D}"usr/bin/wine{,-preloader} #255055
	use abi_x86_64 && pax-mark psmr "${D}"usr/bin/wine64{,-preloader}

	if use abi_x86_64 && ! use abi_x86_32; then
		dosym /usr/bin/wine{64,} # 404331
		dosym /usr/bin/wine{64,}-preloader
	fi

	# respect LINGUAS when installing man pages, #469418
	for l in de fr pl; do
		use linguas_${l} || rm -r "${D}"usr/share/man/${l}*
	done
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
