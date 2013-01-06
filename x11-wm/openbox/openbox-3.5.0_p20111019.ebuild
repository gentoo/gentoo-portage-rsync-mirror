# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.5.0_p20111019.ebuild,v 1.12 2012/12/27 08:29:04 armin76 Exp $

EAPI="2"
inherit multilib autotools eutils

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 arm ~hppa ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="debug imlib nls python session startup-notification static-libs"

RDEPEND="dev-libs/glib:2
	>=dev-libs/libxml2-2.0
	python? ( dev-python/pyxdg )
	>=media-libs/fontconfig-2
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXt
	>=x11-libs/pango-1.8[X]
	imlib? ( media-libs/imlib2 )
	startup-notification? ( >=x11-libs/startup-notification-0.8 )
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xineramaproto"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gnome-session-3.4.9.patch
	sed -i \
		-e "s:-O0 -ggdb ::" \
		-e 's/-fno-strict-aliasing//' \
		"${S}"/m4/openbox.m4 || die
	epatch_user
	eautoreconf
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-silent-rules \
		$(use_enable debug) \
		$(use_enable imlib imlib2) \
		$(use_enable nls) \
		$(use_enable startup-notification) \
		$(use_enable session session-management) \
		$(use_enable static-libs static) \
		--with-x
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox-session" > "${D}/etc/X11/Sessions/${PN}"
	fperms a+x /etc/X11/Sessions/${PN}
	emake DESTDIR="${D}" install || die "emake install failed"
	! use static-libs && rm "${D}"/usr/$(get_libdir)/lib{obt,obrender}.la
	! use python && rm "${D}"/usr/libexec/openbox-xdg-autostart
}
