# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/wine/wine-1.2.3.ebuild,v 1.21 2012/12/26 22:19:44 vapier Exp $

EAPI="4"

inherit eutils flag-o-matic multilib

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://source.winehq.org/git/wine.git"
	inherit git-2 autotools
	SRC_URI=""
	#KEYWORDS=""
else
	AUTOTOOLS_AUTO_DEPEND="no"
	inherit autotools
	MY_P="${PN}-${PV/_/-}"
	SRC_URI="mirror://sourceforge/${PN}/Source/${MY_P}.tar.bz2"
	KEYWORDS="-* amd64 x86 ~x86-fbsd"
	S=${WORKDIR}/${MY_P}
fi

pulse_patches() { echo "$1"/winepulse-{0.36,0.35-configure.ac,0.38-winecfg}.patch ; }
GV="1.0.0-x86"
DESCRIPTION="free implementation of Windows(tm) on Unix"
HOMEPAGE="http://www.winehq.org/"
SRC_URI="${SRC_URI}
	gecko? ( mirror://sourceforge/${PN}/Wine%20Gecko/${GV}/wine_gecko-${GV}.cab )
	pulseaudio? ( `pulse_patches http://art.ified.ca/downloads/winepulse` )"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="alsa capi cups custom-cflags dbus elibc_glibc fontconfig +gecko gnutls gphoto2 gsm jack jpeg lcms ldap mp3 nas ncurses openal +opengl +oss +perl png +prelink pulseaudio samba scanner ssl test +threads +truetype v4l +win32 +win64 +X xcomposite xinerama xml"
REQUIRED_USE="elibc_glibc? ( threads )" #286560
RESTRICT="test" #72375

MLIB_DEPS="amd64? (
	truetype? ( >=app-emulation/emul-linux-x86-xlibs-2.1 )
	X? (
		>=app-emulation/emul-linux-x86-xlibs-2.1
		>=app-emulation/emul-linux-x86-soundlibs-2.1[pulseaudio(+)?]
	)
	mp3? ( app-emulation/emul-linux-x86-soundlibs )
	openal? ( app-emulation/emul-linux-x86-sdl )
	opengl? ( app-emulation/emul-linux-x86-opengl )
	scanner? ( app-emulation/emul-linux-x86-medialibs )
	v4l? ( app-emulation/emul-linux-x86-medialibs )
	app-emulation/emul-linux-x86-baselibs
	>=sys-kernel/linux-headers-2.6
	)"
RDEPEND="truetype? ( >=media-libs/freetype-2.0.0 media-fonts/corefonts )
	perl? ( dev-lang/perl dev-perl/XML-Simple )
	capi? ( net-dialup/capi4k-utils )
	ncurses? ( >=sys-libs/ncurses-5.2 )
	fontconfig? ( media-libs/fontconfig )
	gphoto2? ( media-libs/libgphoto2 )
	jack? ( media-sound/jack-audio-connection-kit )
	openal? ( media-libs/openal )
	dbus? ( sys-apps/dbus )
	gnutls? ( net-libs/gnutls )
	X? (
		x11-libs/libXcursor
		x11-libs/libXrandr
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXxf86vm
	)
	xinerama? ( x11-libs/libXinerama )
	alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )
	cups? ( net-print/cups )
	opengl? (
		virtual/glu
		virtual/opengl
	)
	pulseaudio? ( media-sound/pulseaudio )
	gsm? ( media-sound/gsm )
	jpeg? ( virtual/jpeg )
	ldap? ( net-nds/openldap )
	lcms? ( =media-libs/lcms-1* )
	mp3? ( >=media-sound/mpg123-1.5.0 )
	samba? ( >=net-fs/samba-3.0.25 )
	xml? ( dev-libs/libxml2 dev-libs/libxslt )
	scanner? ( media-gfx/sane-backends )
	ssl? ( dev-libs/openssl )
	png? ( media-libs/libpng )
	v4l? ( media-libs/libv4l )
	!win64? ( ${MLIB_DEPS} )
	win32? ( ${MLIB_DEPS} )
	xcomposite? ( x11-libs/libXcomposite )"
DEPEND="${RDEPEND}
	pulseaudio? ( ${AUTOTOOLS_DEPEND} )
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

src_unpack() {
	if use win64 ; then
		[[ $(( $(gcc-major-version) * 100 + $(gcc-minor-version) )) -lt 404 ]] \
			&& die "you need gcc-4.4+ to build 64bit wine"
	fi

	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${MY_P}.tar.bz2
	fi
}

src_prepare() {
	local md5="$(md5sum server/protocol.def)"
	if use pulseaudio ; then
		EPATCH_OPTS=-p1 epatch `pulse_patches "${DISTDIR}"`
		eautoreconf
	fi
	epatch "${FILESDIR}"/${PN}-1.1.15-winegcc.patch #260726
	epatch "${FILESDIR}"/${PN}-1.2.3-msxml3-libxml2-headers.patch #397993
	epatch_user #282735
	if [[ "$(md5sum server/protocol.def)" != "${md5}" ]]; then
		einfo "server/protocol.def was patched; running tools/make_requests"
		tools/make_requests || die #432348
	fi
	sed -i '/^UPDATE_DESKTOP_DATABASE/s:=.*:=true:' tools/Makefile.in || die
	sed -i '/^MimeType/d' tools/wine.desktop || die #117785
}

do_configure() {
	local builddir="${WORKDIR}/wine$1"
	mkdir -p "${builddir}"
	pushd "${builddir}" >/dev/null

	ECONF_SOURCE=${S} \
	econf \
		--sysconfdir=/etc/wine \
		$(use_with alsa) \
		$(use_with capi) \
		$(use_with lcms cms) \
		$(use_with cups) \
		$(use_with ncurses curses) \
		--without-esd \
		$(use_with fontconfig) \
		$(use_with gnutls) \
		$(use_with gphoto2 gphoto) \
		$(use_with gsm) \
		--without-hal \
		$(use_with jack) \
		$(use_with jpeg) \
		$(use_with ldap) \
		$(use_with mp3 mpg123) \
		$(use_with nas) \
		$(use_with openal) \
		$(use_with opengl) \
		$(use_with ssl openssl) \
		$(use_with oss) \
		$(use_with png) \
		$(use_with threads pthread) \
		$(use pulseaudio && use_with pulseaudio pulse) \
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
	dodoc ANNOUNCE AUTHORS README
	if use gecko ; then
		insinto /usr/share/wine/gecko
		doins "${DISTDIR}"/wine_gecko-${GV}.cab
	fi
	if ! use perl ; then
		rm "${D}"/usr/bin/{wine{dump,maker},function_grep.pl} "${D}"/usr/share/man/man1/wine{dump,maker}.1 || die
	fi
}

pkg_postinst() {
	paxctl -psmr "${ROOT}"/usr/bin/wine{,-preloader} 2>/dev/null #255055
}
