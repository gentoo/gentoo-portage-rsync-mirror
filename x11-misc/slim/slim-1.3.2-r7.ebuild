# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/slim/slim-1.3.2-r7.ebuild,v 1.7 2012/11/04 01:02:57 axs Exp $

EAPI=4

inherit toolchain-funcs pam eutils versionator

DESCRIPTION="Simple Login Manager"
HOMEPAGE="http://slim.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="branding pam consolekit"
REQUIRED_USE="consolekit? ( pam )"

RDEPEND="x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXpm
	x11-libs/libXft
	>=media-libs/libpng-1.4:0
	virtual/jpeg
	x11-apps/sessreg
	consolekit? ( sys-auth/consolekit
		sys-apps/dbus )
	pam? ( virtual/pam )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"
PDEPEND="branding? ( >=x11-themes/slim-themes-1.2.3a-r3 )"

src_prepare() {

	# respect C[XX]FLAGS, fix crosscompile,
	# fix linking order for --as-needed"
	sed -i -e "s:^CXX=.*:CXX=$(tc-getCXX) ${CXXFLAGS}:" \
		-e "s:^CC=.*:CC=$(tc-getCC) ${CFLAGS}:" \
		-e "s:^MANDIR=.*:MANDIR=/usr/share/man:" \
		-e "s:^\t\(.*\)\ \$(LDFLAGS)\ \(.*\):\t\1\ \2\ \$(LDFLAGS):g" \
		-e "s:-I/usr/include/libpng12:$(pkg-config --cflags-only-I libpng):" \
		-e "s:-lpng12:$(pkg-config --libs-only-l libpng):" \
		-r -e "s:^LDFLAGS=(.*):LDFLAGS=\1 ${LDFLAGS}:" \
		Makefile || die "sed failed in Makefile"
	# Our Gentoo-specific config changes
	epatch "${FILESDIR}"/${PN}-1.3.2-r3-config.diff

	if use elibc_FreeBSD; then
		sed -i -e "s/CUSTOM=-DHAVE_SHADOW/CUSTOM=-DNEEDS_BASENAME/" Makefile \
			|| die "sed failed in Makefile"
		epatch "${FILESDIR}"/${PN}-1.3.2-bsd-install.patch
	fi

	if use branding; then
		sed -i -e 's/  default/  slim-gentoo-simple/' slim.conf || die
	fi

	# Gentoo bug 297655
	epatch "${FILESDIR}"/14509-fix-keyboard-in-tty-from-which-${PN}-is-lauched.patch
	# Upstream bug #15287
	epatch "${FILESDIR}"/15287-fix-pam-authentication-with-pam_unix2.patch
	# Gentoo Bug 261713
	epatch "${FILESDIR}"/261713-restart-xserver-if-killed.patch
	# Gentoo bug 261359, upstream 15326
	epatch "${FILESDIR}"/261359-fix-SIGTERM-freeze.patch
	# Gentoo bug 346037
	epatch "${FILESDIR}"/346037-stop_setting_host_for_pam_ck_connector_so.patch
	# Gentoo bug 378505
	epatch "${FILESDIR}"/${P}-libpng15.patch
	# Gentoo bug 252280
	epatch "${FILESDIR}"/252280-fix-default_user-focus_passwd.patch
	# Native consolekit support
	epatch "${FILESDIR}"/${P}-ck.patch
}

src_compile() {
	if use consolekit && use pam ; then
		emake USE_PAM=1 USE_CONSOLEKIT=1
	elif use pam ; then
		emake USE_PAM=1
	else
		emake
	fi
}

src_install() {
	if use pam ; then
		if use consolekit ; then
			emake USE_PAM=1 USE_CONSOLEKIT=1 DESTDIR="${D}" install
		else
			emake USE_PAM=1 DESTDIR="${D}" install
		fi
		pamd_mimic system-local-login slim auth account session
	else
		emake DESTDIR="${D}" install
	fi

	insinto /usr/share/slim
	newins "${FILESDIR}/Xsession-r3" Xsession

	insinto /etc/logrotate.d
	newins "${FILESDIR}/slim.logrotate" slim

	dodoc xinitrc.sample ChangeLog README TODO THEMES
}

pkg_postinst() {
	# note, $REPLACING_VERSIONS will always contain 0 or 1 PV's for slim
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog
		elog "The configuration file is located at /etc/slim.conf."
		elog
		elog "If you wish ${PN} to start automatically, set DISPLAYMANAGER=\"${PN}\" "
		elog "in /etc/conf.d/xdm and run \"rc-update add xdm default\"."
	fi
	if ! version_is_at_least "1.3.2-r7" "${REPLACING_VERSIONS:-1.0}" ; then
		elog
		elog "By default, ${PN} is set up to do proper X session selection, including ~/.xsession"
		elog "support, as well as selection between sessions available in"
		elog "/etc/X11/Sessions/ at login by pressing [F1]."
		elog
		elog "The XSESSION environment variable is still supported as a default"
		elog "if no session has been specified by the user."
		elog
		elog "If you want to use .xinitrc in the user's home directory for session"
		elog "management instead, see README and xinitrc.sample in"
		elog "/usr/share/doc/${PF} and change your login_cmd in /etc/slim.conf"
		elog "accordingly."
		elog
		ewarn "Please note that slim supports consolekit directly.  Please do not use any "
		ewarn "old work-arounds (including calls to 'ck-launch-session' in xinitrc scripts)"
		ewarn "and enable USE=\"consolekit\" instead."
		ewarn
	fi
	if ! use pam; then
		elog "You have merged ${PN} without USE=\"pam\", this will cause ${PN} to fall back to"
		elog "the console when restarting your window manager. If this is not desired, then"
		elog "please remerge ${PN} with USE=\"pam\""
		elog
	fi
}
