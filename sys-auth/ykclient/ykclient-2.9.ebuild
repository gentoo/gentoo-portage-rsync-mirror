# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/ykclient/ykclient-2.9.ebuild,v 1.2 2013/04/22 13:55:05 zerochaos Exp $

EAPI=5

inherit eutils

DESCRIPTION="Yubico C client library"
SRC_URI="http://yubico-c-client.googlecode.com/files/${P}.tar.gz"
HOMEPAGE="https://github.com/Yubico/yubico-c-client"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD-2"
IUSE="static-libs"

RDEPEND=">=net-misc/curl-7.21.1"
DEPEND="${RDEPEND}"

# Tests require an active network connection, we don't want to run them
RESTRICT="test"

src_configure() {
	econf $(use_enable static-libs static)
}

DOCS=( AUTHORS ChangeLog NEWS README )

src_install() {
	default
	prune_libtool_files
}
