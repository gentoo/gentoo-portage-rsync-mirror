# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.9.6.ebuild,v 1.3 2012/10/24 14:50:54 scarabeus Exp $

EAPI=4

inherit alternatives eutils

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0.9"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc test +tools"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit )
"
RDEPEND="${RDEPEND}
	!<app-text/libwpd-0.8.14-r1"

src_configure() {
	econf \
		--disable-static \
		--disable-werror \
		$(use_with doc docs) \
		$(use_with tools stream) \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		--program-suffix=-${SLOT}
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}

pkg_postinst() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpd2html "/usr/bin/wpd2html-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2raw "/usr/bin/wpd2raw-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2text "/usr/bin/wpd2text-[0-9].[0-9]"
	fi
}

pkg_postrm() {
	if use tools; then
		alternatives_auto_makesym /usr/bin/wpd2html "/usr/bin/wpd2html-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2raw "/usr/bin/wpd2raw-[0-9].[0-9]"
		alternatives_auto_makesym /usr/bin/wpd2text "/usr/bin/wpd2text-[0-9].[0-9]"
	fi
}
