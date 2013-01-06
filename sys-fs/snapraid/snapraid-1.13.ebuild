# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/snapraid/snapraid-1.13.ebuild,v 1.1 2012/11/05 15:49:57 ottxor Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="a backup program for disk array for home media centers"
HOMEPAGE="http://snapraid.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ssl test"

DEPEND="ssl? ( dev-libs/openssl:0 )"
RDEPEND="${DEPEND}"

DOCS=( "AUTHORS" "HISTORY" "README" "TODO" "snapraid.conf.example" )
