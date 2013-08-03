# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.5.0_p20130215.ebuild,v 1.10 2013/08/03 06:53:43 ago Exp $

EAPI="4"
inherit multilib autotools python eutils

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz
branding? ( http://dev.gentoo.org/~hwoarang/distfiles/surreal-gentoo.tar.gz )"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 sparc x86 ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="branding debug imlib nls python session startup-notification static-libs"

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
	use python && python_convert_shebangs -r 2 .
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
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
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
	echo "/usr/bin/openbox-session" > "${ED}/etc/X11/Sessions/${PN}"
	fperms a+x /etc/X11/Sessions/${PN}
	emake DESTDIR="${D}" install
	if use branding; then
		insinto /usr/share/themes
		doins -r "${WORKDIR}"/Surreal_Gentoo
		# make it the default theme
		sed -i \
			"/<theme>/{n; s@<name>.*</name>@<name>Surreal_Gentoo</name>@}" \
			"${D}"/etc/xdg/openbox/rc.xml \
			|| die "failed to set Surreal Gentoo as the default theme"
	fi
	! use static-libs && rm "${ED}"/usr/$(get_libdir)/lib{obt,obrender}.la
	! use python && rm "${ED}"/usr/libexec/openbox-xdg-autostart
}
