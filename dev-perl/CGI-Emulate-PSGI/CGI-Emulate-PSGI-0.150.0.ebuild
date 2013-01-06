# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Emulate-PSGI/CGI-Emulate-PSGI-0.150.0.ebuild,v 1.1 2012/11/04 16:27:30 tove Exp $

EAPI=4

MODULE_AUTHOR=MIYAGAWA
MODULE_VERSION=0.15
inherit perl-module

DESCRIPTION="PSGI adapter for CGI"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-perl/HTTP-Message
"
DEPEND="${RDEPEND}
"

SRC_TEST=do

src_install() {
	perl-module_src_install
	rm "${ED}"/usr/share/doc/${PF}/README.mkdn || die
}
