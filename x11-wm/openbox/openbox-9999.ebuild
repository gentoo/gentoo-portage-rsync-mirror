# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-9999.ebuild,v 1.22 2012/12/02 11:14:49 hwoarang Exp $

EAPI="2"
inherit multilib autotools eutils python git-2

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"
SRC_URI="branding? (
http://dev.gentoo.org/~hwoarang/distfiles/surreal-gentoo.tar.gz )"
EGIT_REPO_URI="git://git.openbox.org/dana/openbox"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS=""
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
	app-text/docbook2X
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xineramaproto"

src_prepare() {
	use python && python_convert_shebangs -r 2 .
	epatch "${FILESDIR}"/${PN}-gnome-session-3.4.9.patch
	# Lets try to replace docbook-to-man with docbook2man.pl since
	# Gentoo does not provide (why?) a docbook-to-man package
	sed -i -e "s:docbook-to-man:docbook2man.pl:" "${S}"/Makefile.am
	sed -i \
		-e 's/-fno-strict-aliasing//' \
		m4/openbox.m4 || die
	epatch_user
	eautoreconf
}

src_configure() {
	econf \
		--disable-silent-rules \
		--docdir=/usr/share/doc/${PF} \
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
	if use branding; then
		insinto /usr/share/themes
		doins -r "${WORKDIR}"/Surreal_Gentoo
		# make it the default theme
		sed -i \
			"/<theme>/{n; s@<name>.*</name>@<name>Surreal_Gentoo</name>@}" \
			"${D}"/etc/xdg/openbox/rc.xml \
			|| die "failed to set Surreal Gentoo as the default theme"
	fi
	! use static-libs && rm "${D}"/usr/$(get_libdir)/lib{obt,obrender}.la
	! use python && rm "${D}"/usr/libexec/openbox-xdg-autostart
}
