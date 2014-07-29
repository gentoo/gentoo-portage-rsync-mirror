# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hyperleveldb/hyperleveldb-1.2.0.ebuild,v 1.1 2014/07/29 07:10:52 patrick Exp $

EAPI=5

WANT_AUTOMAKE="1.11"

inherit eutils autotools

DESCRIPTION="Hyperdex fork/extension of leveldb"
HOMEPAGE="http://hyperdex.org/"
SRC_URI="http://hyperdex.org/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-libs/leveldb[snappy]
	"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/snappy.patch"
	eautoreconf
}
