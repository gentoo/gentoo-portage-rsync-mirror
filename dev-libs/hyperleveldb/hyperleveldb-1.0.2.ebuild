# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/hyperleveldb/hyperleveldb-1.0.2.ebuild,v 1.1 2014/02/21 03:13:21 patrick Exp $

EAPI=5

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
