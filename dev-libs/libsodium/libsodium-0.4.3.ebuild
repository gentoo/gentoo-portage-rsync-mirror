# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsodium/libsodium-0.4.3.ebuild,v 1.2 2013/09/10 22:41:17 hasufell Exp $

EAPI=5

inherit eutils

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
SRC_URI="http://download.libsodium.org/${PN}/releases/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+asm static-libs +urandom"

src_configure() {
	econf \
		$(use_enable asm) \
		$(use_enable !urandom blocking-random) \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
