# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libiec61883/libiec61883-1.2.0-r1.ebuild,v 1.1 2013/08/01 17:40:57 aballier Exp $

EAPI=5

inherit autotools-multilib eutils unpacker autotools

DESCRIPTION="Library for capturing video (dv or mpeg2) over the IEEE 1394 bus"
HOMEPAGE="http://dennedy.org/cgi-bin/gitweb.cgi?p=dennedy.org/libiec61883.git"
SRC_URI="mirror://kernel/linux/libs/ieee1394/${P}.tar.xz"

LICENSE="|| ( LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples static-libs"

RDEPEND=">=sys-libs/libraw1394-1.2.1-r1[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-medialibs-20130224-r7
		!app-emulation/emul-linux-x86-medialibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	if use examples; then
		sed -i -e "s:noinst_PROGRAMS.*:noinst_PROGRAMS = :g" \
		-e "s:in_PROGRAMS.*:in_PROGRAMS = plugreport plugctl test-amdtp test-dv	test-mpeg2 test-plugs:g" \
		examples/Makefile.am || die "noinst patching failed"
		AUTOTOOLS_AUTORECONF="1"
	fi
	autotools-multilib_src_prepare
}
