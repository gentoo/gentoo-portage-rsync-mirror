# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/bitcoin-leveldb/bitcoin-leveldb-0.ebuild,v 1.7 2015/03/11 03:00:41 vapier Exp $

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
		=dev-libs/leveldb-1.9.0-r6
		=dev-libs/leveldb-1.10.0-r1
		=dev-libs/leveldb-1.11.0-r1
		=dev-libs/leveldb-1.12.0-r1
		=dev-libs/leveldb-1.13.0-r1
		=dev-libs/leveldb-1.14.0-r1
		=dev-libs/leveldb-1.15.0-r1
		=dev-libs/leveldb-1.17
		~dev-libs/leveldb-1.18
	)"
