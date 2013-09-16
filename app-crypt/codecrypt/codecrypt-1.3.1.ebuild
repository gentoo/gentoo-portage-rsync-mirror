# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/codecrypt/codecrypt-1.3.1.ebuild,v 1.2 2013/09/16 02:13:27 patrick Exp $

EAPI=5

DESCRIPTION="Post-quantum cryptography tool"
HOMEPAGE="http://e-x-a.org/codecrypt/"
SRC_URI="http://e-x-a.org/codecrypt/files/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/gmp
	dev-libs/crypto++"
RDEPEND="${DEPEND}"
