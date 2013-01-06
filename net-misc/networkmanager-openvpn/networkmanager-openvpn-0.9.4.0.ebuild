# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openvpn/networkmanager-openvpn-0.9.4.0.ebuild,v 1.5 2012/08/17 09:44:24 johu Exp $

EAPI="4"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit gnome.org

DESCRIPTION="NetworkManager OpenVPN plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gtk test"

RDEPEND="
	>=dev-libs/dbus-glib-0.74
	>=net-misc/networkmanager-${PV}
	>=net-misc/openvpn-2.1_rc9
	gtk? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

src_prepare() {
	# Test will fail if the machine doesn't have a particular locale installed
	# FAIL: (tls-import-data) unexpected 'ca' secret value
	sed '/test_non_utf8_import (plugin, test_dir)/ d' \
		-i properties/tests/test-import-export.c || die "sed failed"

	# Drop DEPRECATED flags, bug #385597
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		auth-dialog/Makefile.am auth-dialog/Makefile.in \
		common/Makefile.am common/Makefile.in \
		properties/Makefile.am properties/Makefile.in \
		src/Makefile.am src/Makefile.in \
		configure.ac configure || die
}

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-dist-version=Gentoo
		--with-gtkver=3
		$(use_with gtk gnome)
		$(use_with test tests)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}
