# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellstock/gkrellstock-0.5.ebuild,v 1.15 2012/03/25 15:16:06 armin76 Exp $

inherit gkrellm-plugin

IUSE=""
S=${WORKDIR}/${P/s/S}
DESCRIPTION="Get Stock quotes plugin for Gkrellm2"
SRC_URI="mirror://sourceforge/gkrellstock/${P}.tar.gz"
HOMEPAGE="http://gkrellstock.sourceforge.net/"

RDEPEND="dev-perl/libwww-perl
	dev-perl/Finance-Quote"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

src_install () {
	gkrellm-plugin_src_install

	exeinto /usr/bin
	doexe GetQuote2
}
