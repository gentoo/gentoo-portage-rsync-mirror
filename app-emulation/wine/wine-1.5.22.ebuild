# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-1.5.22.ebuild,v 1.5 2013/08/05 09:31:06 ssuominen Exp $

EAPI="5"

inherit autotools eutils flag-o-matic gnome2-utils multilib pax-utils

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

GV="1.9"
MV="0.0.8"
PULSE_PATCHES="winepulse-patches-1.5.22"
WINE_GENTOO="wine-gentoo-2012.11.24"
DESCRIPTION="Free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.winehq.org/"
SRC_URI="${SRC_URI}
	gecko? (
		mirror://sourceforge/${PN}/Wine%20Gecko/${GV}/wine_gecko-${GV}-x86.msi
		win64? ( mirror://sourceforge/${PN}/Wine%20Gecko/${GV}/wine_gecko-${GV}-x86_64.msi )
	)
	mono? ( mirror://sourceforge/${PN}/Wine%20Mono/${MV}/wine-mono-${MV}.msi )
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${PULSE_PATCHES}.tar.bz2
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${WINE_GENTOO}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa capi cups custom-cflags elibc_glibc fontconfig +gecko gnutls gphoto2 gsm gstreamer jpeg lcms ldap +mono mp3 ncurses nls odbc openal opencl +opengl osmesa +oss +perl png +prelink samba scanner selinux ssl test +threads +truetype udisks v4l +win32 +win64 +X xcomposite xinerama xml"
[[ ${PV} == "9999" ]] || IUSE="${IUSE} pulseaudio"
REQUIRED_USE="elibc_glibc? ( threads )
	mono? ( || ( win32 !win64 ) )
	osmesa? ( opengl )" #286560
RESTRICT="test" #72375

MLIB_DEPS="amd64? (
	gstreamer? ( app-emulation/emul-linux-x86-gstplugins )
	truetype? ( >=app-emulation/emul-linux-x86-xlibs-2.1 )
	X? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-soundlibs-2.1
	)
	mp3? ( app-emulation/emul-linux-x86-soundlibs )
	odbc? ( app-emulation/emul-linux-x86-db )
	openal? ( app-emulation/emul-linux-x86-sdl )
	opengl? ( app-emulation/emul-linux-x86-opengl )
	osmesa? ( >=app-emulation/emul-linux-x86-opengl-20121028 )
	scanner? ( app-emulation/emul-linux-x86-medialibs )
	v4l? ( app-emulation/emul-linux-x86-medialibs )
	app-emulation/emul-linux-x86-baselibs
	>=sys-kernel/linux-headers-2.6
	)"
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
	gnutls? ( net-libs/gnutls:= )
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
	jpeg? ( virtual/jpeg:0= )
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
	ssl? ( dev-libs/openssl:0= )
	png? ( media-libs/libpng:0= )
	v4l? ( media-libs/libv4l )
	!win64? ( ${MLIB_DEPS} )
	win32? ( ${MLIB_DEPS} )
	xcomposite? ( x11-libs/libXcomposite )"
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
	if use win64 ; then
		[[ $(( $(gcc-major-version) * 100 + $(gcc-minor-version) )) -lt 404 ]] \
			&& die "you need gcc-4.4+ to build 64bit wine"
	fi

	if use win32 && use opencl; then
		[[ x$(eselect opencl show) = "xintel" ]] &&
			die "Cannot build wine[opencl,win32]: intel-ocl-sdk is 64-bit only" # 403947
	fi

	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${MY_P}.tar.bz2
	fi

	unpack "${PULSE_PATCHES}.tar.bz2"
	unpack "${WINE_GENTOO}.tar.bz2"
}

src_prepare() {
	local md5="$(md5sum server/protocol.def)"
	epatch "${FILESDIR}"/${PN}-1.1.15-winegcc.patch #260726
	epatch "${FILESDIR}"/${PN}-1.4_rc2-multilib-portage.patch #395615
	epatch "${FILESDIR}"/${PN}-1.5.17-osmesa-check.patch #429386
	[[ ${PV} == "9999" ]] || epatch "../${PULSE_PATCHES}"/*.patch #421365
	epatch_user #282735
	if [[ "$(md5sum server/protocol.def)" != "${md5}" ]]; then
		einfo "server/protocol.def was patched; running tools/make_requests"
		tools/make_requests || die #432348
	fi
	eautoreconf
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in || die
	sed -i '/^MimeType/d' tools/wine.desktop || die #117785
}

do_configure() {
	local builddir="${WORKDIR}/wine$1"
	mkdir -p "${builddir}"
	pushd "${builddir}" >/dev/null

	local usepulse
	[[ ${PV} == "9999" ]] || usepulse=$(use_with pulseaudio pulse)

	ECONF_SOURCE=${S} \
	econf \
		--sysconfdir=/etc/wine \
		$(use_with alsa) \
		$(use_with capi) \
		$(use_with lcms cms) \
		$(use_with cups) \
		$(use_with ncurses curses) \
		$(use_with udisks dbus) \
		$(use_with fontconfig) \
		$(use_with gnutls) \
		$(use_with gphoto2 gphoto) \
		$(use_with gsm) \
		$(use_with gstreamer) \
		--without-hal \
		$(use_with jpeg) \
		$(use_with ldap) \
		$(use_with mp3 mpg123) \
		$(use_with nls gettext) \
		$(use_with openal) \
		$(use_with opencl) \
		$(use_with opengl) \
		$(use_with ssl openssl) \
		$(use_with osmesa) \
		$(use_with oss) \
		$(use_with png) \
		$(use_with threads pthread) \
		${usepulse} \
		$(use_with scanner sane) \
		$(use_enable test tests) \
		$(use_with truetype freetype) \
		$(use_with v4l) \
		$(use_with X x) \
		$(use_with xcomposite) \
		$(use_with xinerama) \
		$(use_with xml) \
		$(use_with xml xslt) \
		$2

	emake -j1 depend

	popd >/dev/null
}

src_configure() {
	export LDCONFIG=/bin/true
	use custom-cflags || strip-flags

	if use win64 ; then
		do_configure 64 --enable-win64
		use win32 && ABI=x86 do_configure 32 --with-wine64=../wine64
	else
		ABI=x86 do_configure 32 --disable-win64
	fi
}

src_compile() {
	local b
	for b in 64 32 ; do
		local builddir="${WORKDIR}/wine${b}"
		[[ -d ${builddir} ]] || continue
		emake -C "${builddir}" all
	done
}

src_install() {
	local b
	for b in 64 32 ; do
		local builddir="${WORKDIR}/wine${b}"
		[[ -d ${builddir} ]] || continue
		emake -C "${builddir}" install DESTDIR="${D}"
	done
	emake -C "../${WINE_GENTOO}" install DESTDIR="${D}" EPREFIX="${EPREFIX}"
	dodoc ANNOUNCE AUTHORS README
	if use gecko ; then
		insinto /usr/share/wine/gecko
		doins "${DISTDIR}"/wine_gecko-${GV}-x86.msi
		use win64 && doins "${DISTDIR}"/wine_gecko-${GV}-x86_64.msi
	fi
	if use mono ; then
		insinto /usr/share/wine/mono
		doins "${DISTDIR}"/wine-mono-${MV}.msi
	fi
	if ! use perl ; then
		rm "${D}"usr/bin/{wine{dump,maker},function_grep.pl} "${D}"usr/share/man/man1/wine{dump,maker}.1 || die
	fi

	if use win32 || ! use win64; then
		pax-mark psmr "${D}"usr/bin/wine{,-preloader} #255055
	fi
	use win64 && pax-mark psmr "${D}"usr/bin/wine64{,-preloader}

	if use win64 && ! use win32; then
		dosym /usr/bin/wine{64,} # 404331
		dosym /usr/bin/wine{64,}-preloader
	fi
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
