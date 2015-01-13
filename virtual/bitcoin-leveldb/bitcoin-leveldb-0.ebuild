# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/bitcoin-leveldb/bitcoin-leveldb-0.ebuild,v 1.4 2015/01/13 11:46:19 blueness Exp $

EAPI=5

DESCRIPTION="Virtual for LevelDB versions known to be compatible with Bitcoin Core 0.9+"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 arm x86"

DEPEND=""
RDEPEND="
	|| (
		=dev-libs/leveldb-1.9.0-r6[-snappy]
		=dev-libs/leveldb-1.10.0-r1[-snappy]
		=dev-libs/leveldb-1.11.0-r1[-snappy]
		=dev-libs/leveldb-1.12.0-r1[-snappy]
		=dev-libs/leveldb-1.13.0-r1[-snappy]
		=dev-libs/leveldb-1.14.0[-snappy]
		=dev-libs/leveldb-1.15.0-r1[-snappy]
		=dev-libs/leveldb-1.17[-snappy]
	)"
