# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-UPnP/Net-UPnP-1.4.2-r1.ebuild,v 1.1 2013/09/08 13:55:40 idella4 Exp $

EAPI=5

MODULE_AUTHOR=SKONNO
inherit perl-module

DESCRIPTION="Perl extension for UPnP"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-solaris"
# Package warrants IUSE examples
IUSE=""

RDEPEND="virtual/perl-version"
DEPEND="${RDEPEND}"

SRC_TEST=do

src_install() {
	perl-module_src_install
	dodir usr/share/doc/${PF}/examples || die
	docompress -x usr/share/doc/${PF}/examples
	insinto usr/share/doc/${PF}/
	doins -r examples/
}
