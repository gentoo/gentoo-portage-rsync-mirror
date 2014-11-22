# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsodium/libsodium-1.0.1.ebuild,v 1.1 2014/11/22 22:08:49 mrueg Exp $

EAPI=5

inherit eutils

DESCRIPTION="A portable fork of NaCl, a higher-level cryptographic library"
HOMEPAGE="https://github.com/jedisct1/libsodium"
SRC_URI="http://download.libsodium.org/${PN}/releases/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/13"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~x86 ~amd64-linux ~x86-linux"
IUSE="+asm minimal static-libs +urandom"

src_configure() {
	econf \
		$(use_enable asm) \
		$(use_enable minimal) \
		$(use_enable !urandom blocking-random) \
		$(use_enable static-libs static)
}

src_install() {
	default
	prune_libtool_files
}
