# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/modemmanager/modemmanager-0.4.ebuild,v 1.10 2012/12/02 22:46:07 ssuominen Exp $

EAPI="2"

inherit gnome.org eutils multilib udev

# ModemManager likes itself with capital letters
MY_PN="${PN/modemmanager/ModemManager}"

DESCRIPTION="Modem and mobile broadband management libraries"
HOMEPAGE="http://mail.gnome.org/archives/networkmanager-list/2008-July/msg00274.html"
SRC_URI="${SRC_URI//${PN}/${MY_PN}}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE="doc policykit test"

RDEPEND=">=dev-libs/glib-2.18
	virtual/udev[gudev]
	>=dev-libs/dbus-glib-0.86
	net-dialup/ppp
	policykit? ( >=sys-auth/polkit-0.95 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	# fix building against glib-2.31 headers
	epatch "${FILESDIR}/${PN}-0.5-glib-2.31.patch"
}

src_configure() {
	# ppp-2.4.5 will change the plugin directory (not added to portage yet)
	if has_version '=net-dialup/ppp-2.4.4*'; then
		pppd_plugin_dir="pppd/2.4.4"
	elif has_version '=net-dialup/ppp-2.4.5*'; then
		pppd_plugin_dir="pppd/2.4.5"
	fi

	econf \
		--disable-more-warnings \
		--with-udev-base-dir="$(udev_get_udevdir)" \
		--disable-static \
		--with-dist-version=${PVR} \
		--with-pppd-plugin-dir="/usr/$(get_libdir)/${pppd_plugin_dir}" \
		$(use_with doc docs) \
		$(use_with policykit polkit) \
		$(use_with test tests)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
	# Remove useless .la files
	rm -vf "${D}"/usr/$(get_libdir)/{${MY_PN},${pppd_plugin_dir}}/*.la
}

pkg_postinst() {
	elog "If your USB modem shows up as a Flash drive when you plug it in,"
	elog "You should install sys-apps/usb_modeswitch which will automatically"
	elog "switch it over to USB modem mode whenever you plug it in."
}
