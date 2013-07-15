# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libusbx/libusbx-1.0.16.ebuild,v 1.1 2013/07/15 08:42:02 ssuominen Exp $

EAPI=5
inherit eutils

DESCRIPTION="Userspace access to USB devices"
HOMEPAGE="http://libusbx.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 -x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE="debug doc examples static-libs test udev"

RDEPEND="!dev-libs/libusb:1
	udev? ( >=virtual/udev-200 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

DOCS="AUTHORS ChangeLog NEWS PORTING README THANKS TODO"

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable udev) \
		$(use_enable debug debug-log) \
		$(use_enable test tests-build)
}

src_compile() {
	default

	use doc && emake -C doc docs
}

src_test() {
	default

	# noinst_PROGRAMS from tests/Makefile.am
	tests/stress || die
}

src_install() {
	default

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.{c,h}
	fi

	use doc && dohtml doc/html/*

	prune_libtool_files
}
