# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/barry/barry-0.17.1-r1.ebuild,v 1.4 2012/12/11 15:54:56 axs Exp $

EAPI="4"

inherit autotools-utils bash-completion eutils udev toolchain-funcs

DESCRIPTION="Sync, backup, program management, and charging for BlackBerry devices"
HOMEPAGE="http://www.netdirect.ca/software/packages/barry/"
SRC_URI="mirror://sourceforge/barry/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="boost doc gui opensync nls static-libs"

RDEPEND="
	dev-libs/glib:2
	virtual/libusb:0
	dev-libs/openssl
	sys-libs/zlib
	>=dev-cpp/libxmlpp-2.6
	>=dev-libs/libtar-1.2.11-r2
	boost?	( >=dev-libs/boost-1.33 )
	gui?	( dev-cpp/glibmm:2
			  dev-cpp/gtkmm:2.4
			  dev-cpp/libglademm:2.4 )
	opensync? ( ~app-pda/libopensync-0.22 )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc?	( >=app-doc/doxygen-1.5.6 )
	nls?	( >=sys-devel/gettext-0.17 )"

PATCHES=( "${FILESDIR}"/${P}-gcc47.patch )

DOCS=(AUTHORS DEPUTY ChangeLog NEWS README TODO)

src_configure() {
	myeconfargs=(
		$(use_enable boost)
		$(use_enable gui)
		$(use_enable nls)
		$(use_enable opensync opensync-plugin)
		--disable-rpath
	)
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
	if use doc ; then
		cd "${S}"
		doxygen || die
	fi
}

src_install() {
	autotools-utils_src_install

	# docs
	rm -rf "${S}"/doc/www/*.php
	rm -rf "${S}"/doc/www/*.sh
	find "${S}"/doc/www/doxygen/html -name "*.map" -size 0 -exec rm -f {} +

	if use doc; then
		dohtml "${S}"/doc/www/doxygen/html/*
	fi

	rm -rf "${S}"/doc/www
	dodoc -r "${S}"/doc/*

	#  udev rules
	udev_dorules "${S}"/udev/10-blackberry.rules
#	udev_dorules "${S}"/udev/69-blackberry.rules
	sed -i -e 's:plugdev:usb:g' "${S}"/udev/99-blackberry-perms.rules || die
	udev_dorules "${S}"/udev/99-blackberry-perms.rules

	#  blacklist for BERRY_CHARGE kernel module
	insinto /etc/modprobe.d
	doins "${S}"/modprobe/blacklist-berry_charge.conf

	# pppd options files
	docinto "${DOCDIR}"/ppp/
	dodoc "${S}"/ppp/*

	BASHCOMPFILES="${S}/bash/btool ${S}/bash/bjavaloader"
	dobashcompletion

	if use gui; then
		domenu "${S}"/menu/barrybackup.desktop || die
		doicon "${S}"/logo/barry_logo_icon.png || die
	fi
}

pkg_postinst() {
	einfo
	elog "Barry requires you to be a member of the \"usb\" group."
	einfo
	bash-completion_pkg_postinst
	ewarn
	ewarn "Barry and the in-kernel module 'BERRY_CHARGE' are incompatible."
	ewarn
	ewarn "Kernel-based USB suspending can discharge your blackberry."
	ewarn "Use at least kernel 2.6.22 and/or disable CONFIG_USB_SUSPEND."
	ewarn
}
