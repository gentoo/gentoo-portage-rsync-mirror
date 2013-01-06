# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/keytouch/keytouch-2.4.1.ebuild,v 1.7 2012/05/05 04:53:46 jdhore Exp $

EAPI=2
inherit eutils linux-info

DESCRIPTION="Easily configure extra keyboard function keys"
HOMEPAGE="http://keytouch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="acpi kde"

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXtst
	gnome-base/gnome-menus:0
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/inputproto
	x11-proto/xextproto
	x11-proto/xproto"
RDEPEND="${RDEPEND}
	acpi? ( sys-power/acpid )
	kde? ( || (
		kde-base/kdesu
		kde-base/kdebase
	) )
	!kde? ( x11-libs/gksu )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc28.patch
	sed -i \
		's/install-data-local//1' \
		keytouch{-acpid,d,-init}/Makefile.in \
		|| die "sed failed"
	sed -i \
		-e '/^CFLAGS/s:\(.*\)=\(.*\)-O2:\1+=\2$(LDFLAGS):' \
		{mxml,plugins}/Makefile.in \
		|| die "sed failed"
}

d_iter() {
	local d
	for d in . keytouch-config keytouch-keyboard ; do
		pushd ${d} > /dev/null
		eval "${1}"
		popd > /dev/null
	done
}

src_configure() {
	d_iter 'econf'
}

src_compile() {
	d_iter 'emake || die "emake ${d} failed"'
}

src_install() {
	if use acpi ; then
		newinitd "${FILESDIR}"/${PN}-acpid ${PN} || die "newinitd failed"
	else
		doinitd "${FILESDIR}"/${PN} || die "doinitd failed"
	fi

	newicon keytouch-keyboard/pixmaps/icon.png ${PN}.png
	make_desktop_entry ${PN} keyTouch ${PN} System

	dodoc AUTHORS ChangeLog

	d_iter 'emake DESTDIR="${D}" install || die "emake install ${d} failed"'
}

pkg_postinst() {
	echo
	elog "To use keyTouch, add \"keytouchd\" to your"
	elog "X startup programs and run"
	elog "\"rc-update add keytouch default\""
	elog
	elog "If support for your keyboard is not included in"
	elog "this release, check for new keyboard files at"
	elog "${HOMEPAGE}dl-keyboards.html"
	elog
	elog "x11-misc/keytouch-editor can be used to create"
	elog "your own keyboard files"
	echo
	if use acpi; then
	if ! linux_config_exists || ! linux_chkconfig_present INPUT_EVDEV; then
		ewarn "To enable support for ACPI hotkeys, CONFIG_INPUT_EVDEV"
		ewarn "must be enabled in your kernel config."
		ewarn
		ewarn "  Device Drivers"
		ewarn "    Input device support"
		ewarn "      <*>/<M> Event interface"
		echo
	fi
	fi
}
