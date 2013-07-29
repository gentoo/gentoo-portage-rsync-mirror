# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/codecrypt/codecrypt-1.2.ebuild,v 1.1 2013/07/29 14:48:48 yac Exp $

EAPI=5

DESCRIPTION="Post-quantum cryptography tool"
HOMEPAGE="http://e-x-a.org/codecrypt/"
SRC_URI="http://e-x-a.org/codecrypt/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"
