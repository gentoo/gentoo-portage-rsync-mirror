# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsodium/libsodium-0.4.5.ebuild,v 1.3 2013/10/28 16:14:55 bicatali Exp $

EAPI=5

inherit eutils

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
SRC_URI="http://download.libsodium.org/${PN}/releases/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-linux ~x86-linux"
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
