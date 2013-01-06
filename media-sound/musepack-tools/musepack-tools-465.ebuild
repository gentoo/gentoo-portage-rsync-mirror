# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musepack-tools/musepack-tools-465.ebuild,v 1.11 2013/01/01 12:30:21 ago Exp $

EAPI=3
inherit cmake-utils

# svn export http://svn.musepack.net/libmpc/trunk musepack-tools-${PV}
# tar -cjf musepack-tools-${PV}.tar.bz2 musepack-tools-${PV}

DESCRIPTION="Musepack SV8 libraries and utilities"
HOMEPAGE="http://www.musepack.net"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=media-libs/libcuefile-${PV}
	>=media-libs/libreplaygain-${PV}
	!media-libs/libmpcdec
	!media-libs/libmpcdecsv7"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-gentoo.patch" )
