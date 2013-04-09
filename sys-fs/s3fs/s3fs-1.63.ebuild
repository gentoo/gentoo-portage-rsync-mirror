# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/s3fs/s3fs-1.63.ebuild,v 1.3 2013/04/09 18:24:38 ago Exp $

EAPI=5

inherit toolchain-funcs

DESCRIPTION="Amazon mounting S3 via fuse"
HOMEPAGE="http://s3fs.googlecode.com/"
SRC_URI="http://s3fs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

CDEPEND=">=dev-libs/libxml2-2.6:2
	dev-libs/openssl
	>=net-misc/curl-7.0
	>=sys-fs/fuse-2.8.4"
RDEPEND="${CDEPEND}
	app-misc/mime-types"
DEPEND="${CDEPEND}
	virtual/pkgconfig"

RESTRICT="test"
