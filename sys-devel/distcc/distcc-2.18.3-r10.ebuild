# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-2.18.3-r10.ebuild,v 1.16 2014/05/12 11:36:29 ssuominen Exp $

EAPI=5
inherit eutils flag-o-matic toolchain-funcs user

PATCHLEVEL="2.18"

DESCRIPTION="a program to distribute compilation of C code across several machines on a network"
HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
IUSE="gnome gtk hardened selinux ipv6"

DEPEND=">=sys-devel/gcc-config-1.3.1
	userland_GNU? ( sys-apps/shadow )
	gnome? ( virtual/pkgconfig )
	gtk? ( virtual/pkgconfig )"
RDEPEND="
	gnome? (
		x11-libs/gtk+:2
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0.0
		gnome-base/libglade:2.0
		x11-libs/pango
		>=gnome-base/gconf-2.0.0:2
	)
	gtk? (
		x11-libs/gtk+:2
		x11-libs/pango
	)
	selinux? ( sec-policy/selinux-distcc )"

src_prepare() {
	# -Wl,--as-needed to close bug #128605
	epatch "${FILESDIR}/distcc-as-needed.patch"

	# See bug #75420 for more multilib stuff
	epatch "${FILESDIR}/distcc-gentoo-multilib-r1.patch"
	einfo "Please report to bug #75420 success or failure of this patch."

	# Bugs #120001, #167844 and probably more. See patch for description.
	use hardened && epatch "${FILESDIR}/distcc-hardened.patch"
}

src_configure() {
	local myconf="--with-included-popt "
	#Here we use the built in parse-options package. saves a dependancy

	#not taking any chances here, guessing which takes precedence in the
	#configure script, so we'll just make the distinction here:
	#gnome takes precedence over gtk if both are specified (gnome pulls
	#in gtk anyways...)
	use gtk && ! use gnome && myconf="${myconf} --with-gtk"
	use gtk && use gnome && myconf="${myconf} --with-gnome"

	#More legacy stuff?
	[ `gcc-major-version` -eq 2 ] && filter-lfs-flags

	if use ipv6; then
		ewarn "To use IPV6 you must have IPV6 compiled into your kernel"
		ewarn "either via a module or compiled code"
		ewarn "You can recompile without ipv6 with: USE='-ipv6' emerge distcc"
		myconf=" ${myconf} --enable-rfc2553 "
	fi
	econf ${myconf}
}

src_install() {
	emake -j1 DESTDIR="${D%/}" install

	insinto /usr/share/doc/${PN}
	doins "${S}/survey.txt"

	exeinto /usr/bin
	doexe "${FILESDIR}/distcc-config"

	newconfd "${FILESDIR}/${PATCHLEVEL}/conf" distccd

	newinitd "${FILESDIR}/${PATCHLEVEL}/init" distccd

	# create and keep the symlink dir
	dodir /usr/lib/distcc/bin
	keepdir /usr/lib/distcc/bin

	# create the distccd pid directory
	dodir /var/run/distccd
	keepdir /var/run/distccd

	if use gnome || use gtk; then
	  einfo "Renaming /usr/bin/distccmon-gnome to /usr/bin/distccmon-gui"
	  einfo "This is to have a little sensability in naming schemes between distccmon programs"
	  mv "${D}/usr/bin/distccmon-gnome" "${D}/usr/bin/distccmon-gui"
	  dosym /usr/bin/distccmon-gui /usr/bin/distccmon-gnome
	fi

}

pkg_preinst() {
	# non-/ installs don't require us to do anything here
	[ "${ROOT}" != "/" ] && return 0

	# stop daemon since script is being updated
	[ -n "$(pidof distccd)" -a -x /etc/init.d/distccd ] && \
		/etc/init.d/distccd stop
}

pkg_postinst() {
	#are we doing bootstrap with has no useradd?
	if [[ ${CHOST} != *-*-gnu && ${CHOST} != *-linux* ]] || [ -x /usr/sbin/useradd ]; then
	  enewuser distcc 240
	else
	  ewarn "You do not have useradd (bootstrap) from shadow so I didn't"
	  ewarn "install the distcc user.  Note that attempting to start the daemon"
	  ewarn "will fail. Please install shadow and re-emerge distcc."
	fi

	# By now everyone should be using the right envfile

	if [ "${ROOT}" = "/" ]; then
		einfo "Installing links to native compilers..."
		/usr/bin/distcc-config --install
	else
		# distcc-config can *almost* handle ROOT installs itself
		#  but for now, but user must finsh things off
		ewarn "*** Installation is not complete ***"
		ewarn "You must run the following as root:"
		ewarn "  /usr/bin/distcc-config --install"
		ewarn "after booting or chrooting into ${ROOT}"
	fi
	einfo "Setting permissions on ${ROOT}var/run/distccd"
	chown -R distcc:daemon "${ROOT}var/run/distccd"
	echo ""

	einfo "Tips on using distcc with Gentoo can be found at"
	einfo "http://www.gentoo.org/doc/en/distcc.xml"
	echo ""
	einfo "To use the distccmon programs with Gentoo you should use this command:"
	einfo "      DISTCC_DIR=/var/tmp/portage/.distcc distccmon-text N"
	use gnome || use gtk && einfo "Or:   DISTCC_DIR=/var/tmp/portage/.distcc distccmon-gnome"

	ewarn "***SECURITY NOTICE***"
	ewarn "If you are upgrading distcc please make sure to run etc-update to"
	ewarn "update your /etc/conf.d/distccd and /etc/init.d/distccd files with"
	ewarn "added security precautions (the --listen and --allow directives)"
	ebeep 5
}
