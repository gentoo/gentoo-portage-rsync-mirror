# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/p11-kit/p11-kit-0.19.4.ebuild,v 1.3 2014/08/10 02:26:59 patrick Exp $

EAPI=5

inherit eutils

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="http://p11-glue.freedesktop.org/p11-kit.html"
SRC_URI="http://p11-glue.freedesktop.org/releases/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="+asn1 debug +trust"
REQUIRED_USE="trust? ( asn1 )"

RDEPEND="asn1? ( >=dev-libs/libtasn1-2.14 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable trust trust-module) \
		$(use_enable debug) \
		$(use_with asn1 libtasn1)
}

src_install() {
	default
	prune_libtool_files --modules
}
