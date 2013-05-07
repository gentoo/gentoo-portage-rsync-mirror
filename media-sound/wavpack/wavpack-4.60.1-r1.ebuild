# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.60.1-r1.ebuild,v 1.1 2013/05/07 12:55:13 mgorny Exp $

EAPI=5

AUTOTOOLS_PRUNE_LIBTOOL_FILES=all
inherit autotools-multilib

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
IUSE="mmx static-libs"

RDEPEND="virtual/libiconv
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20121202 )"

DEPEND="${RDEPEND}"

DOCS=( ChangeLog README )

src_configure() {
	local myeconfargs=(
		$(use_enable mmx)
	)

	autotools-multilib_src_configure
}
