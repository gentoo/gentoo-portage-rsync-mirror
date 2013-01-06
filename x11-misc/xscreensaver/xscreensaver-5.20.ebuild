# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xscreensaver/xscreensaver-5.20.ebuild,v 1.9 2012/12/16 19:56:05 armin76 Exp $

EAPI=4
inherit autotools eutils flag-o-matic multilib pam

DESCRIPTION="A modular screen saver and locker for the X Window System"
HOMEPAGE="http://www.jwz.org/xscreensaver/"
SRC_URI="http://www.jwz.org/xscreensaver/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-solaris ~x86-solaris"
IUSE="gdm jpeg new-login opengl pam +perl selinux suid xinerama"

COMMON_DEPEND="dev-libs/libxml2
	>=gnome-base/libglade-2
	media-libs/netpbm
	x11-apps/appres
	x11-apps/xwininfo
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXt
	x11-libs/libXxf86misc
	x11-libs/libXxf86vm
	jpeg? ( virtual/jpeg )
	new-login? (
		gdm? ( gnome-base/gdm )
		!gdm? ( || ( x11-misc/lightdm kde-base/kdm ) )
		)
	opengl? ( virtual/opengl )
	pam? ( virtual/pam )
	selinux? ( sec-policy/selinux-xscreensaver )
	xinerama? ( x11-libs/libXinerama )"
# For USE="perl" see output of `qlist xscreensaver | grep bin | xargs grep '::'`
RDEPEND="${COMMON_DEPEND}
	perl? (
		dev-lang/perl
		dev-perl/libwww-perl
		virtual/perl-Digest-MD5
		)"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/bc
	sys-devel/gettext
	x11-proto/recordproto
	x11-proto/scrnsaverproto
	x11-proto/xextproto
	x11-proto/xf86miscproto
	x11-proto/xf86vidmodeproto
	xinerama? ( x11-proto/xineramaproto )"

REQUIRED_USE="gdm? ( new-login )"

src_prepare() {
	if use new-login && ! use gdm; then #392967
		sed -i \
			-e "/default_l.*1/s:gdmflexiserver -ls:${EPREFIX}/usr/libexec/lightdm/&:" \
			configure{,.in} || die
	fi

	epatch \
		"${FILESDIR}"/${PN}-5.15-gentoo.patch \
		"${FILESDIR}"/${PN}-5.05-interix.patch \
		"${FILESDIR}"/${PN}-5.20-blurb-hndl-test-passwd.patch \
		"${FILESDIR}"/${PN}-5.20-check-largefile-support.patch \
		"${FILESDIR}"/${PN}-5.20-conf264.patch \
		"${FILESDIR}"/${PN}-5.20-test-passwd-segv-tty.patch \
		"${FILESDIR}"/${PN}-5.20-tests-miscfix.patch \
		"${FILESDIR}"/${PN}-5.20-parallel-build.patch

	eautoconf
	eautoheader
}

src_configure() {
	if use ppc || use ppc64; then
		filter-flags -maltivec -mabi=altivec
		append-flags -U__VEC__
	fi

	unset LINGUAS #113681
	unset BC_ENV_ARGS #24568
	export RPM_PACKAGE_VERSION=no #368025

	econf \
		--x-includes="${EPREFIX}"/usr/include \
		--x-libraries="${EPREFIX}"/usr/$(get_libdir) \
		--enable-locking \
		--with-hackdir="${EPREFIX}"/usr/$(get_libdir)/misc/${PN} \
		--with-configdir="${EPREFIX}"/usr/share/${PN}/config \
		--with-x-app-defaults="${EPREFIX}"/usr/share/X11/app-defaults \
		--with-dpms-ext \
		$(use_with xinerama xinerama-ext) \
		--with-xinput-ext \
		--with-xf86vmode-ext \
		--with-xf86gamma-ext \
		--with-randr-ext \
		--with-proc-interrupts \
		$(use_with pam) \
		--without-kerberos \
		$(use_with new-login login-manager) \
		--with-gtk \
		$(use_with opengl gl) \
		--without-gle \
		--with-pixbuf \
		$(use_with jpeg) \
		--with-xshm-ext \
		--with-xdbe-ext \
		--with-text-file="${EPREFIX}"/etc/gentoo-release \
		$(use_with suid setuid-hacks)
}

src_install() {
	emake install_prefix="${D}" install
	dodoc README{,.hacking}

	use pam && fperms 755 /usr/bin/${PN}
	pamd_mimic_system ${PN} auth

	rm -f "${ED}"/usr/share/${PN}/config/{electricsheep,fireflies}.xml
}
