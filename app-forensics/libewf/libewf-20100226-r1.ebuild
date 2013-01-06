# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libewf/libewf-20100226-r1.ebuild,v 1.9 2012/03/01 23:30:28 ranger Exp $

EAPI="4"

inherit autotools-utils

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://libewf.sourceforge.net"
SRC_URI="mirror://sourceforge/libewf/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc x86"
# upstream bug #2597171, pyewf has implicit declarations
#IUSE="debug python rawio unicode"
IUSE="debug ewf2 rawio static-libs unicode"

DEPEND="
	sys-libs/e2fsprogs-libs
	sys-libs/zlib
	dev-libs/openssl"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )

src_configure() {
	local myeconfargs=(
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable ewf2 v2-api)
		$(use_enable rawio low-level-functions)
		$(use_enable unicode wide-character-type)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	doman manuals/*.1 manuals/*.3
}
