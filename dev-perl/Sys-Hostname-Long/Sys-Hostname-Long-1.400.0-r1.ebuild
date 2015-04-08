# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sys-Hostname-Long/Sys-Hostname-Long-1.400.0-r1.ebuild,v 1.1 2014/08/22 18:20:23 axs Exp $

EAPI=5

MODULE_AUTHOR=SCOTT
MODULE_VERSION=1.4
inherit perl-module

DESCRIPTION="Try every conceivable way to get full hostname"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

src_install() {
	perl-module_src_install
	rm "${ED}${VENDOR_LIB}"/Sys/Hostname/testall.pl || die
	dodoc testall.pl
	docompress -x /usr/share/doc/${PF}/testall.pl
}
