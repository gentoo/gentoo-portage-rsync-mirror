# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/libewf/libewf-20130105.ebuild,v 1.1 2013/01/14 05:47:36 radhermit Exp $

EAPI="5"

inherit autotools-utils

DESCRIPTION="Implementation of the EWF (SMART and EnCase) image format"
HOMEPAGE="http://code.google.com/p/libewf/"
SRC_URI="http://libewf.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
# upstream bug #2597171, pyewf has implicit declarations
#IUSE="debug python rawio unicode"
IUSE="debug ewf +fuse rawio +ssl static-libs +uuid unicode"

DEPEND="
	sys-libs/zlib
	fuse? ( sys-fs/fuse )
	uuid? ( sys-apps/util-linux )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1

DOCS=( AUTHORS ChangeLog NEWS README documents/header.txt documents/header2.txt )

src_configure() {
	local myeconfargs=(
		$(use_enable debug debug-output)
		$(use_enable debug verbose-output)
		$(use_enable ewf v1-api)
		$(use_enable rawio low-level-functions)
		$(use_enable unicode wide-character-type)
		$(use_with ssl openssl)
		$(use_with uuid libuuid)
		$(use_with fuse libfuse)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	doman manuals/*.1 manuals/*.3
}
