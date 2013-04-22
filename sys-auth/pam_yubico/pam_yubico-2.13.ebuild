# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_yubico/pam_yubico-2.13.ebuild,v 1.2 2013/04/22 14:04:54 zerochaos Exp $

EAPI=5
inherit eutils autotools

DESCRIPTION="Library for authenticating against PAM with a Yubikey"
HOMEPAGE="https://code.google.com/p/yubico-pam/"
SRC_URI="http://yubico-pam.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ldap"

DEPEND="virtual/pam
	>=sys-auth/ykclient-2.4
	>=sys-auth/ykpers-1.6
	ldap? ( net-nds/openldap )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/2.11-drop_privs.patch"
	eautoreconf
}

src_configure() {
	#challenge response could be optional but that seems horribly dangerous to me
	econf \
		--with-cr \
		$(use_with ldap) \
		--with-pam-dir=/$(get_libdir)/security
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README doc/*
	#prune_libtool_files #why doesn't this work?
	find "${D}" -name '*.la' -delete || die
}
