# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libcerf/libcerf-1.3.ebuild,v 1.4 2014/07/24 01:51:07 naota Exp $

EAPI=5

inherit autotools-utils multilib

DESCRIPTION="library that provides an efficient and accurate implementation of complex error functions"
HOMEPAGE="http://apps.jcns.fz-juelich.de/doku/sc/libcerf"
SRC_URI="http://apps.jcns.fz-juelich.de/src/${PN}/${P}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~x86-fbsd ~amd64-linux ~x86-macos"
IUSE="doc static-libs test"

DEPEND=""
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-autotools.patch" )
AUTOTOOLS_AUTORECONF=1
