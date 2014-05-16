# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/avahi/avahi-0.6.31-r3.ebuild,v 1.3 2014/05/16 18:53:22 swift Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="gdbm"

WANT_AUTOMAKE=1.11

inherit autotools eutils flag-o-matic multilib mono-env python-r1 systemd user

DESCRIPTION="System which facilitates service discovery on a local network"
HOMEPAGE="http://avahi.org/"
SRC_URI="http://avahi.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-linux"
IUSE="autoipd bookmarks dbus doc gdbm gtk gtk3 howl-compat +introspection ipv6 kernel_linux mdnsresponder-compat mono nls python qt4 selinux test utils"

REQUIRED_USE="
	utils? ( || ( gtk gtk3 ) )
	python? ( dbus gdbm )
	mono? ( dbus )
	howl-compat? ( dbus )
	mdnsresponder-compat? ( dbus )
"

COMMON_DEPEND="
	dev-libs/libdaemon
	dev-libs/expat
	dev-libs/glib:2
	gdbm? ( sys-libs/gdbm )
	qt4? ( dev-qt/qtcore:4 )
	gtk? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	dbus? ( sys-apps/dbus )
	kernel_linux? ( sys-libs/libcap )
	introspection? ( dev-libs/gobject-introspection )
	mono? (
		dev-lang/mono
		gtk? ( dev-dotnet/gtk-sharp )
	)
	python? (
		${PYTHON_DEPS}
		gtk? ( dev-python/pygtk )
		dbus? ( dev-python/dbus-python )
	)
	selinux? ( sec-policy/selinux-avahi )
	bookmarks? (
		dev-python/twisted-core
		dev-python/twisted-web
	)
"

DEPEND="
	${COMMON_DEPEND}
	dev-util/intltool
	virtual/pkgconfig
	doc? (
		app-doc/doxygen
	)
"

RDEPEND="
	${COMMON_DEPEND}
	howl-compat? ( !net-misc/howl )
	mdnsresponder-compat? ( !net-misc/mDNSResponder )
"

pkg_preinst() {
	enewgroup netdev
	enewgroup avahi
	enewuser avahi -1 -1 -1 avahi

	if use autoipd; then
		enewgroup avahi-autoipd
		enewuser avahi-autoipd -1 -1 -1 avahi-autoipd
	fi
}

pkg_setup() {
	use mono && mono-env_pkg_setup
}

src_prepare() {
	if use ipv6; then
		sed -i \
			-e s/use-ipv6=no/use-ipv6=yes/ \
			avahi-daemon/avahi-daemon.conf || die
	fi

	sed -i\
		-e "s:\\.\\./\\.\\./\\.\\./doc/avahi-docs/html/:../../../doc/${PF}/html/:" \
		doxygen_to_devhelp.xsl || die

	# Make gtk utils optional
	epatch "${FILESDIR}"/${PN}-0.6.30-optional-gtk-utils.patch

	# Fix init scripts for >=openrc-0.9.0, bug #383641
	epatch "${FILESDIR}"/${PN}-0.6.x-openrc-0.9.x-init-scripts-fixes.patch

	# install-exec-local -> install-exec-hook
	epatch "${FILESDIR}"/${P}-install-exec-hook.patch

	# Backport host-name-from-machine-id patch, bug #466134
	epatch "${FILESDIR}"/${P}-host-name-from-machine-id.patch

	# Don't install avahi-discover unless ENABLE_GTK_UTILS, bug #359575
	epatch "${FILESDIR}"/${P}-fix-install-avahi-discover.patch

	# Drop DEPRECATED flags, bug #384743
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED=1::g' avahi-ui/Makefile.am || die

	# Fix references to Lennart's home directory, bug #466210
	sed -i -e 's/\/home\/lennart\/tmp\/avahi//g' man/* || die

	# Prevent .pyc files in DESTDIR
	>py-compile

	eautoreconf
}

src_configure() {
	use sh && replace-flags -O? -O0

	local myconf="--disable-static"

	if use python; then
		python_export_best
		myconf+="
			$(use_enable dbus python-dbus)
			$(use_enable gtk pygtk)
		"
	fi

	if use mono; then
		myconf+=" $(use_enable doc monodoc)"
	fi

	# We need to unset DISPLAY, else the configure script might have problems detecting the pygtk module
	unset DISPLAY

	econf \
		--localstatedir="${EPREFIX}/var" \
		--with-distro=gentoo \
		--disable-python-dbus \
		--disable-pygtk \
		--disable-xmltoman \
		--disable-monodoc \
		--enable-glib \
		--enable-gobject \
		$(use_enable test tests) \
		$(use_enable autoipd) \
		$(use_enable mdnsresponder-compat compat-libdns_sd) \
		$(use_enable howl-compat compat-howl) \
		$(use_enable doc doxygen-doc) \
		$(use_enable mono) \
		$(use_enable dbus) \
		$(use_enable python) \
		$(use_enable gtk) \
		$(use_enable gtk3) \
		$(use_enable nls) \
		$(use_enable introspection) \
		$(use_enable utils gtk-utils) \
		--disable-qt3 \
		$(use_enable qt4) \
		$(use_enable gdbm) \
		$(systemd_with_unitdir) \
		${myconf}
}

src_compile() {
	emake || die "emake failed"

	use doc && { emake avahi.devhelp || die ; }
}

src_install() {
	emake install DESTDIR="${D}" || die "make install failed"
	use bookmarks && use python && use dbus && use gtk || \
		rm -f "${ED}"/usr/bin/avahi-bookmarks

	use howl-compat && ln -s avahi-compat-howl.pc "${ED}"/usr/$(get_libdir)/pkgconfig/howl.pc
	use mdnsresponder-compat && ln -s avahi-compat-libdns_sd/dns_sd.h "${ED}"/usr/include/dns_sd.h

	if use autoipd; then
		insinto /$(get_libdir)/rcscripts/net
		doins "${FILESDIR}"/autoipd.sh || die

		insinto /$(get_libdir)/rc/net
		newins "${FILESDIR}"/autoipd-openrc.sh autoipd.sh || die
	fi

	dodoc docs/{AUTHORS,NEWS,README,TODO} || die

	if use doc; then
		dohtml -r doxygen/html/. || die
		insinto /usr/share/devhelp/books/avahi
		doins avahi.devhelp || die
	fi

	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	if use autoipd; then
		elog
		elog "To use avahi-autoipd to configure your interfaces with IPv4LL (RFC3927)"
		elog "addresses, just set config_<interface>=( autoipd ) in /etc/conf.d/net!"
		elog
	fi
}
