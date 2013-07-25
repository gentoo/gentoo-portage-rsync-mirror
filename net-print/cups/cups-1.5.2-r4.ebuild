# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups/cups-1.5.2-r4.ebuild,v 1.20 2013/07/25 11:50:21 dilfridge Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.5"
GENTOO_DEPEND_ON_PERL=no

inherit autotools eutils fdo-mime gnome2-utils flag-o-matic linux-info multilib pam perl-module python user versionator java-pkg-opt-2

MY_P=${P/_}
MY_PV=${PV/_}

DESCRIPTION="The Common Unix Printing System"
HOMEPAGE="http://www.cups.org/"
SRC_URI="mirror://easysw/${PN}/${MY_PV}/${MY_P}-source.tar.bz2
	http://dev.gentoo.org/~dilfridge/distfiles/${P}-ipp-r8950.patch.bz2
	http://dev.gentoo.org/~dilfridge/distfiles/${P}-avahi.patch.bz2
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="m68k s390"
IUSE="acl avahi dbus debug +filters gnutls java +jpeg kerberos ldap pam perl
	+png python selinux slp +ssl static-libs +threads +tiff usb X xinetd"

LANGS="es"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="
	app-text/libpaper
	acl? (
		kernel_linux? (
			sys-apps/acl
			sys-apps/attr
		)
	)
	avahi? ( net-dns/avahi )
	dbus? ( sys-apps/dbus )
	java? ( >=virtual/jre-1.6 )
	jpeg? ( virtual/jpeg:0 )
	kerberos? ( virtual/krb5 )
	ldap? ( net-nds/openldap[ssl?,gnutls?] )
	pam? ( virtual/pam )
	perl? ( dev-lang/perl )
	png? ( >=media-libs/libpng-1.4.3:0 )
	selinux? ( sec-policy/selinux-cups )
	slp? ( >=net-libs/openslp-1.0.4 )
	ssl? (
		gnutls? (
			dev-libs/libgcrypt
			net-libs/gnutls
		)
		!gnutls? ( >=dev-libs/openssl-0.9.8g )
	)
	tiff? ( >=media-libs/tiff-3.5.5:0 )
	usb? ( virtual/libusb:0 )
	X? ( x11-misc/xdg-utils )
	xinetd? ( sys-apps/xinetd )
	!net-print/cups-filters
"

DEPEND="${RDEPEND}
	virtual/pkgconfig
"

PDEPEND="
	app-text/ghostscript-gpl[cups]
	>=app-text/poppler-0.12.3-r3[utils]
	filters? ( net-print/foomatic-filters )
"

REQUIRED_USE="gnutls? ( ssl )"

# upstream includes an interactive test which is a nono for gentoo
RESTRICT="test"

S="${WORKDIR}/${MY_P}"

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
	# various build time fixes
	epatch "${FILESDIR}/${PN}-1.4.4-dont-compress-manpages.patch"
	epatch "${FILESDIR}/${PN}-1.4.4-fix-install-perms.patch"
	epatch "${FILESDIR}/${PN}-1.4.4-nostrip.patch"
	epatch "${FILESDIR}/${PN}-1.4.4-php-destdir.patch"
	epatch "${FILESDIR}/${PN}-1.4.4-perl-includes.patch"
	epatch "${FILESDIR}/${PN}-1.5.2-linkperl.patch"
	epatch "${FILESDIR}/${PN}-1.5.2-threads.patch"
	epatch "${FILESDIR}/${PN}-1.5.2-threads2.patch"

	# revert ipp backend to 1.4 state, as ubuntu and debian
	epatch "${DISTDIR}/${PN}-1.5.2-ipp-r8950.patch.bz2"

	# avahi support from debian
	epatch "${DISTDIR}/${PN}-1.5.2-avahi.patch.bz2"

	# browsing off by default
	epatch "${FILESDIR}/${PN}-1.5.2-browsing.patch"

	AT_M4DIR=config-scripts eaclocal
	eautoconf
}

src_configure() {
	export DSOFLAGS="${LDFLAGS}"

	# locale support
	strip-linguas ${LANGS}
	if [ -z "${LINGUAS}" ] ; then
		export LINGUAS=none
	fi

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
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var \
		--with-cups-user=lp \
		--with-cups-group=lp \
		--with-docdir=/usr/share/cups/html \
		--with-languages="${LINGUAS}" \
		--with-pdftops=/usr/bin/pdftops \
		--with-system-groups=lpadmin \
		$(use_enable acl) \
		$(use_enable avahi) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable debug debug-guards) \
		$(use_enable jpeg) \
		$(use_enable kerberos gssapi) \
		$(use_enable ldap) \
		$(use_enable pam) \
		$(use_enable png) \
		$(use_enable slp) \
		$(use_enable static-libs static) \
		$(use_enable threads) \
		$(use_enable tiff) \
		$(use_enable usb libusb) \
		$(use_with java) \
		$(use_with perl) \
		--without-php \
		$(use_with python) \
		$(use_with xinetd xinetd /etc/xinetd.d) \
		--enable-libpaper \
		--disable-dnssd \
		${myconf}

	# install in /usr/libexec always, instead of using /usr/lib/cups, as that
	# makes more sense when facing multilib support.
	sed -i -e 's:SERVERBIN.*:SERVERBIN = "$(BUILDROOT)"/usr/libexec/cups:' Makedefs || die
	sed -i -e 's:#define CUPS_SERVERBIN.*:#define CUPS_SERVERBIN "/usr/libexec/cups":' config.h || die
	sed -i -e 's:cups_serverbin=.*:cups_serverbin=/usr/libexec/cups:' cups-config || die
}

src_compile() {
	emake

	if use perl ; then
		cd "${S}"/scripting/perl
		perl-module_src_prep
		perl-module_src_compile
	fi
}

src_install() {
	emake BUILDROOT="${D}" install
	dodoc {CHANGES,CREDITS,README}.txt

	if use perl ; then
		pushd scripting/perl > /dev/null
		perl-module_src_install
		fixlocalpod
		popd > /dev/null
	fi

	# clean out cups init scripts
	rm -rf "${ED}"/etc/{init.d/cups,rc*,pam.d/cups}

	# install our init script
	local neededservices
	use avahi && neededservices+=" avahi-daemon"
	use dbus && neededservices+=" dbus"
	[[ -n ${neededservices} ]] && neededservices="need${neededservices}"
	cp "${FILESDIR}"/cupsd.init.d "${T}"/cupsd || die
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
	echo "ServerName /var/run/cups/cups.sock" >> "${ED}"/etc/cups/client.conf
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	# Update desktop file database and gtk icon cache (bug 370059)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update

	echo
	elog "For information about installing a printer and general cups setup"
	elog "take a look at: http://www.gentoo.org/doc/en/printing-howto.xml"
	echo
	elog "Network browsing for printers is now switched off by default in the config file."
	elog "To (re-)enable it, edit /etc/cups/cupsd.conf and set \"Browsing On\", "
	elog "afterwards re-start or reload cups."
	echo
}

pkg_postrm() {
	# Update desktop file database and gtk icon cache (bug 370059)
	gnome2_icon_cache_update
	fdo-mime_desktop_database_update
}
