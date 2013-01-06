# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gnokii/gnokii-0.6.27-r2.ebuild,v 1.17 2012/09/05 09:20:17 jlec Exp $

EAPI="1"

inherit eutils linux-info autotools

DESCRIPTION="user space driver and tools for use with mobile phones"
HOMEPAGE="http://www.gnokii.org/"
SRC_URI="http://www.gnokii.org/download/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE="nls bluetooth ical irda sms postgres mysql usb X debug"

RDEPEND="!app-mobilephone/smstools
	sys-apps/pcsc-lite
	X? ( x11-libs/gtk+:2 )
	bluetooth? ( net-wireless/bluez )
	sms? (
		!app-mobilephone/smstools
		dev-libs/glib:2
		postgres? ( >=dev-db/postgresql-base-8.0 )
		mysql? ( >=virtual/mysql-4.1 )
	)
	ical? ( dev-libs/libical )
	usb? ( =virtual/libusb-0* )"
DEPEND="${RDEPEND}
	irda? ( virtual/os-headers )
	nls? ( sys-devel/gettext )
	dev-util/intltool"

CONFIG_CHECK="~UNIX98_PTYS"

# Supported languages and translated documentation
# Be sure all languages are prefixed with a single space!
MY_AVAILABLE_LINGUAS=" cs de et fi fr it nl pl pt sk sl sv zh_CN"
IUSE="${IUSE} ${MY_AVAILABLE_LINGUAS// / linguas_}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-icon.patch
	epatch "${FILESDIR}"/${P}-disable-database.patch

	eautoreconf
}

src_compile() {
	strip-linguas ${MY_AVAILABLE_LINGUAS}

	local config_xdebug="--disable-xdebug"
	use X && use debug && config_xdebug="--enable-xdebug"

	econf \
		$(use_enable nls) \
		$(use_enable ical libical) \
		$(use_enable usb libusb) \
		$(use_enable irda) \
		$(use_enable bluetooth) \
		$(use_with X x) \
		$(use_enable sms smsd) \
		$(use_enable mysql) \
		$(use_enable postgres) \
		$(use_enable debug fulldebug) \
		${config_xdebug} \
		$(use_enable debug rlpdebug) \
		--enable-security \
		--disable-unix98test \
		--enable-libpcsclite \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"

	insinto /etc
	doins Docs/sample/gnokiirc
	sed -i -e 's:/usr/local:/usr:' "${D}/etc/gnokiirc"

	# only one file needs suid root to make a pseudo device
	fperms 4755 /usr/sbin/mgnokiidev

	if use X; then
		newicon Docs/sample/logo/gnokii.xpm xgnokii.xpm
	fi

	if use sms; then
		pushd "${S}/smsd"
		insinto /usr/share/doc/${PN}/smsd
		use mysql && doins sms.tables.mysql.sql README.MySQL
		use postgres && doins sms.tables.pq.sql
		doins README ChangeLog README.Tru64 action
		popd
	fi
}

pkg_postinst() {
	elog "Make sure the user that runs gnokii has read/write access to the device"
	elog "which your phone is connected to."
	elog "The simple way of doing that is to add your user to the uucp group."
}
