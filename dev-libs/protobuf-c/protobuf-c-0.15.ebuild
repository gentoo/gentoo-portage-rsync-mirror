# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/protobuf-c/protobuf-c-0.15.ebuild,v 1.4 2014/06/24 19:22:43 maekke Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="code generator and runtime libraries to use Protocol Buffers (protobuf) from pure C"
HOMEPAGE="http://code.google.com/p/protobuf-c/"
SRC_URI="http://protobuf-c.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE="static-libs"

RDEPEND="dev-libs/protobuf"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
