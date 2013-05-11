# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.6.2-r4.ebuild,v 1.2 2013/05/11 22:16:12 dilfridge Exp $

EAPI=5

PYTHON_DEPEND="python? 2:2.5"

inherit autotools base fdo-mime gnome2-utils flag-o-matic linux-info multilib pam python user versionator java-pkg-opt-2 systemd

MY_P=${P/_beta/b}
MY_PV=${PV/_beta/b}

if [[ "${PV}" != "9999" ]]; then
	SRC_URI="mirror://easysw/${PN}/${MY_PV}/${MY_P}-source.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
else
	inherit subversion
	ESVN_REPO_URI="http://svn.easysw.com/public/cups/trunk"
	KEYWORDS=""
fi

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="acl dbus debug +filters gnutls java kerberos lprng-compat pam
	python selinux +ssl static-libs +threads usb X xinetd zeroconf"

LANGS="ca es fr ja ru"
for X in ${LANGS} ; do
	IUSE="${IUSE} +linguas_${X}"
done

RDEPEND="
	app-text/libpaper
	acl? (
		kernel_linux? (
			sys-apps/acl
			sys-apps/attr
		)
	)
	dbus? ( sys-apps/dbus )
	java? ( >=virtual/jre-1.6 )
	kerberos? ( virtual/krb5 )
	!lprng-compat? ( !net-print/lprng )
	pam? ( virtual/pam )
	selinux? ( sec-policy/selinux-cups )
	ssl? (
		gnutls? (
			dev-libs/libgcrypt
			net-libs/gnutls
		)
		!gnutls? ( >=dev-libs/openssl-0.9.8g )
	)
	usb? ( virtual/libusb:0 )
	X? ( x11-misc/xdg-utils )
	xinetd? ( sys-apps/xinetd )
	zeroconf? ( net-dns/avahi )
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PDEPEND="
	app-text/ghostscript-gpl[cups]
	app-text/poppler[utils]
	>=net-print/cups-filters-1.0.30
	filters? ( net-print/foomatic-filters )
"

REQUIRED_USE="gnutls? ( ssl )"

# upstream includes an interactive test which is a nono for gentoo
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${PN}-1.6.0-dont-compress-manpages.patch"
	"${FILESDIR}/${PN}-1.6.0-fix-install-perms.patch"
	"${FILESDIR}/${PN}-1.4.4-nostrip.patch"
	"${FILESDIR}/${PN}-1.5.0-systemd-socket-2.patch"	# systemd support
	"${FILESDIR}/${PN}-1.6.2-statedir.patch"
)

pkg_setup() {
	enewgroup lp
	enewuser lp -1 -1 -1 lp
	enewgroup lpadmin 106

	# python 3 is no-go
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi

	if use kernel_linux; then
		linux-info_pkg_setup
		if  ! linux_config_exists; then
			ewarn "Can't check the linux kernel configuration."
			ewarn "You might have some incompatible options enabled."
		else
			# recheck that we don't have usblp to collide with libusb
			if use usb; then
				if linux_chkconfig_present USB_PRINTER; then
					eerror "Your usb printers will be managed via libusb. In this case, "
					eerror "${P} requires the USB_PRINTER support disabled."
					eerror "Please disable it:"
					eerror "    CONFIG_USB_PRINTER=n"
					eerror "in /usr/src/linux/.config or"
					eerror "    Device Drivers --->"
					eerror "        USB support  --->"
					eerror "            [ ] USB Printer support"
					eerror "Alternatively, just disable the usb useflag for cups (your printer will still work)."
				fi
			else
				#here we should warn user that he should enable it so he can print
				if ! linux_chkconfig_present USB_PRINTER; then
					ewarn "If you plan to use USB printers you should enable the USB_PRINTER"
					ewarn "support in your kernel."
					ewarn "Please enable it:"
					ewarn "    CONFIG_USB_PRINTER=y"
					ewarn "in /usr/src/linux/.config or"
					ewarn "    Device Drivers --->"
					ewarn "        USB support  --->"
					ewarn "            [*] USB Printer support"
					ewarn "Alternatively, enable the usb useflag for cups and use the libusb code."
				fi
			fi
		fi
	fi
}

src_prepare() {
	base_src_prepare
	AT_M4DIR=config-scripts eaclocal
	eautoconf
}

src_configure() {
	export DSOFLAGS="${LDFLAGS}"

	einfo LANGS=\"${LANGS}\"
	einfo LINGUAS=\"${LINGUAS}\"

	local myconf
	if use ssl ; then
		myconf+="
			$(use_enable gnutls)
			$(use_enable !gnutls openssl)
		"
	else
		myconf+="
			--disable-gnutls
			--disable-openssl
		"
	fi

	econf \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--localstatedir="${EPREFIX}"/var \
		--with-cups-user=lp \
		--with-cups-group=lp \
		--with-docdir="${EPREFIX}"/usr/share/cups/html \
		--with-languages="${LINGUAS}" \
		--with-system-groups=lpadmin \
		$(use_enable acl) \
		$(use_enable zeroconf avahi) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable debug debug-guards) \
		$(use_enable kerberos gssapi) \
		$(use_enable pam) \
		$(use_enable static-libs static) \
		$(use_enable threads) \
		$(use_enable usb libusb) \
		--disable-dnssd \
		$(use_with java) \
		--without-perl \
		--without-php \
		$(use_with python) \
		$(use_with xinetd xinetd /etc/xinetd.d) \
		--enable-libpaper \
		--with-systemdsystemunitdir="$(systemd_get_unitdir)" \
		${myconf}

	# install in /usr/libexec always, instead of using /usr/lib/cups, as that
	# makes more sense when facing multilib support.
	sed -i -e 's:SERVERBIN.*:SERVERBIN = "$(BUILDROOT)${EPREFIX}"/usr/libexec/cups:' Makedefs || die
	sed -i -e 's:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN "${EPREFIX}/usr/libexec/cups":' config.h || die
	sed -i -e 's:cups_serverbin=.*:cups_serverbin=${EPREFIX}/usr/libexec/cups:' cups-config || die
}

src_install() {
	# Fix install-sh, posix sh does not have 'function'.
	sed 's#function gzipcp#gzipcp()#g' -i "${S}/install-sh"

	emake BUILDROOT="${D}" install
	dodoc {CHANGES,CREDITS,README}.txt

	# move the default config file to docs
	dodoc "${ED}"/etc/cups/cupsd.conf.default
	rm -f "${ED}"/etc/cups/cupsd.conf.default

	# clean out cups init scripts
	rm -rf "${ED}"/etc/{init.d/cups,rc*,pam.d/cups}

	# install our init script
	local neededservices
	use zeroconf && neededservices+=" avahi-daemon"
	use dbus && neededservices+=" dbus"
	[[ -n ${neededservices} ]] && neededservices="need${neededservices}"
	cp "${FILESDIR}"/cupsd.init.d-r1 "${T}"/cupsd || die
	sed -i \
		-e "s/@neededservices@/$neededservices/" \
		"${T}"/cupsd || die
	doinitd "${T}"/cupsd

	# install our pam script
	pamd_mimic_system cups auth account

	if use xinetd ; then
		# correct path
		sed -i \
			-e "s:server = .*:server = /usr/libexec/cups/daemon/cups-lpd:" \
			"${ED}"/etc/xinetd.d/cups-lpd || die
		# it is safer to disable this by default, bug #137130
		grep -w 'disable' "${ED}"/etc/xinetd.d/cups-lpd || \
			{ sed -i -e "s:}:\tdisable = yes\n}:" "${ED}"/etc/xinetd.d/cups-lpd || die ; }
		# write permission for file owner (root), bug #296221
		fperms u+w /etc/xinetd.d/cups-lpd || die "fperms failed"
	else
		rm -rf "${ED}"/etc/xinetd.d
	fi

	keepdir /usr/libexec/cups/driver /usr/share/cups/{model,profiles} \
		/var/cache/cups /var/cache/cups/rss /var/log/cups \
		/var/spool/cups/tmp

	keepdir /etc/cups/{interfaces,ppd,ssl}

	use X || rm -r "${ED}"/usr/share/applications

	# create /etc/cups/client.conf, bug #196967 and #266678
	echo "ServerName /run/cups/cups.sock" >> "${ED}"/etc/cups/client.conf

	# the following files are now provided by cups-filters:
	rm -r "${ED}"/usr/share/cups/banners || die
	rm -r "${ED}"/usr/share/cups/data/testprint || die

	# for the special case of running lprng and cups together, bug 467226
	if use lprng-compat ; then
		rm -fv "${ED}"/usr/bin/{lp*,cancel}
		rm -fv "${ED}"/usr/sbin/lp*
		rm -fv "${ED}"/usr/share/man/man1/{lp*,cancel*}
		rm -fv "${ED}"/usr/share/man/man8/lp*
		ewarn "Not installing lp... binaries, since the lprng-compat useflag is set."
		ewarn "Unless you plan to install an exotic server setup, you most likely"
		ewarn "do not want this. Disable the useflag then and all will be fine."
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	# Update desktop file database and gtk icon cache (bug 370059)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update

	# not slotted - at most one value
	if ! [[ "${REPLACING_VERSIONS}" ]]; then
		echo
		elog "For information about installing a printer and general cups setup"
		elog "take a look at: http://www.gentoo.org/doc/en/printing-howto.xml"
		echo
	fi

	if [[ "${REPLACING_VERSIONS}" ]] && [[ "${REPLACING_VERSIONS}" < "1.6" ]]; then
		echo
		elog "CUPS-1.6 no longer supports automatic remote printers or implicit classes"
		elog "via the CUPS, LDAP, or SLP protocols, i.e. \"network browsing\"."
		elog "You will have to find printers using zeroconf/avahi instead, enter"
		elog "the location manually, or run cups-browsed from net-print/cups-filters"
		elog "which re-adds that functionality as a separate daemon."
		echo
	elif [[ "${REPLACING_VERSIONS}" ]] && [[ "${REPLACING_VERSIONS}" < "1.6.2" ]]; then
		echo
		elog "Starting with net-print/cups-filters-1.0.30, that package provides"
		elog "a daemon cups-browsed which implements printer discovery via the"
		elog "Cups-1.5 protocol. Not much tested so far though."
		echo
	fi
}

pkg_postrm() {
	# Update desktop file database and gtk icon cache (bug 370059)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
