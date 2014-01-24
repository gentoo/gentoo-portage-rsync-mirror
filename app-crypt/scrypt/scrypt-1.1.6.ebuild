# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/scrypt/scrypt-1.1.6.ebuild,v 1.1 2014/01/24 09:04:15 radhermit Exp $

EAPI=5

DESCRIPTION="A simple password-based encryption utility using the scrypt key derivation function"
HOMEPAGE="http://www.tarsnap.com/scrypt.html"
SRC_URI="http://www.tarsnap.com/${PN}/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sse2"

DOCS=( FORMAT )

src_configure() {
	econf $(use_enable sse2)
}
