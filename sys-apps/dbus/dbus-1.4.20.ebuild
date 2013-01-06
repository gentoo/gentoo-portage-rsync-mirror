# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dbus/dbus-1.4.20.ebuild,v 1.13 2012/07/15 18:08:37 armin76 Exp $

EAPI=4
inherit autotools eutils multilib flag-o-matic python systemd virtualx user

DESCRIPTION="A message bus system, a simple way for applications to talk to each other"
HOMEPAGE="http://dbus.freedesktop.org/"
SRC_URI="http://dbus.freedesktop.org/releases/dbus/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE="debug doc selinux static-libs test X"

RDEPEND=">=dev-libs/expat-2
	selinux? (
		sec-policy/selinux-dbus
		sys-libs/libselinux
		)
	X? (
		x11-libs/libX11
		x11-libs/libXt
		)"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? (
		app-doc/doxygen
		app-text/docbook-xml-dtd:4.1.2
		app-text/xmlto
		)
	test? (
		>=dev-libs/glib-2.24
		dev-lang/python:2.7
		)"

# out of sources build directory
BD=${WORKDIR}/${P}-build
# out of sources build dir for make check
TBD=${WORKDIR}/${P}-tests-build

pkg_setup() {
	enewgroup messagebus
	enewuser messagebus -1 -1 -1 messagebus

	# FIXME: Test suite fails with Python 3.2 (last checked: 1.4.20)
	if use test; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	# Tests were restricted because of this
	sed -i \
		-e 's/.*bus_dispatch_test.*/printf ("Disabled due to excess noise\\n");/' \
		-e '/"dispatch"/d' \
		bus/test-main.c || die

	epatch \
		"${FILESDIR}"/${PN}-1.4.0-asneeded.patch \
		"${FILESDIR}"/${PN}-1.5.12-selinux-when-dropping-capabilities-only-include-AUDI.patch

	# required for asneeded patch but also for bug 263909, cross-compile so
	# don't remove eautoreconf
	eautoreconf
}

src_configure() {
	local myconf

	# so we can get backtraces from apps
	append-flags -rdynamic

	# libaudit is *only* used in DBus wrt SELinux support, so disable it, if
	# not on an SELinux profile.
	myconf=(
		--disable-asserts
		--disable-checks
		--disable-embedded-tests
		--disable-modular-tests
		$(use_with X x)
		$(use_enable debug verbose-mode)
		$(use_enable kernel_linux inotify)
		$(use_enable kernel_FreeBSD kqueue)
		$(use_enable selinux)
		$(use_enable selinux libaudit)
		$(use_enable static-libs static)
		--enable-shared
		--with-xml=expat
		--with-system-pid-file=/var/run/dbus.pid
		--with-system-socket=/var/run/dbus/system_bus_socket
		--with-session-socket-dir=/tmp
		--with-dbus-user=messagebus
		"$(systemd_with_unitdir)"
		--localstatedir=/var
		--docdir=/usr/share/doc/${PF}
		--htmldir=/usr/share/doc/${PF}/html
		)

	mkdir "${BD}"
	cd "${BD}"
	einfo "Running configure in ${BD}"
	ECONF_SOURCE="${S}" econf "${myconf[@]}" \
		$(use_enable doc doxygen-docs) \
		$(use_enable doc xml-docs)

	if use test; then
		mkdir "${TBD}"
		cd "${TBD}"
		einfo "Running configure in ${TBD}"
		ECONF_SOURCE="${S}" econf "${myconf[@]}" \
			$(use_enable test checks) \
			$(use_enable test embedded-tests) \
			$(use_enable test asserts) \
			$(has_version dev-libs/dbus-glib && echo --enable-modular-tests)
	fi
}

src_compile() {
	# after the compile, it uses a selinuxfs interface to
	# check if the SELinux policy has the right support
	use selinux && addwrite /selinux/access

	cd "${BD}"
	einfo "Running make in ${BD}"
	emake

	if use test; then
		cd "${TBD}"
		einfo "Running make in ${TBD}"
		emake
	fi
}

src_test() {
	cd "${TBD}"
	DBUS_VERBOSE=1 Xemake -j1 check
}

src_install() {
	newinitd "${FILESDIR}"/dbus.initd dbus

	if use X; then
		# dbus X session script (#77504)
		# turns out to only work for GDM (and startx). has been merged into
		# other desktop (kdm and such scripts)
		exeinto /etc/X11/xinit/xinitrc.d
		doexe "${FILESDIR}"/80-dbus
	fi

	# needs to exist for dbus sessions to launch
	keepdir /usr/share/dbus-1/services
	keepdir /etc/dbus-1/system.d
	keepdir /etc/dbus-1/session.d
	keepdir /var/lib/dbus # See pkg_postinst() for symlink creation

	dodoc AUTHORS ChangeLog HACKING NEWS README doc/TODO

	cd "${BD}"
	emake DESTDIR="${D}" install

	find "${ED}" -type f -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	elog "To start the D-Bus system-wide messagebus by default"
	elog "you should add it to the default runlevel :"
	elog "\`rc-update add dbus default\`"
	elog
	elog "Some applications require a session bus in addition to the system"
	elog "bus. Please see \`man dbus-launch\` for more information."
	elog
	ewarn "You must restart D-Bus \`/etc/init.d/dbus restart\` to run"
	ewarn "the new version of the daemon."
	ewarn "Don't do this while X is running because it will restart your X as well."

	# Ensure unique id is generated and put it in /etc wrt #370451 but symlink
	# for DBUS_MACHINE_UUID_FILE (see tools/dbus-launch.c) and reverse
	# dependencies with hardcoded paths (although the known ones got fixed already)
	dbus-uuidgen --ensure="${EROOT}"/etc/machine-id
	ln -sf "${EROOT}"/etc/machine-id "${EROOT}"/var/lib/dbus/machine-id
}
