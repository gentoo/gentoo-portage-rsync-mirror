# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mhonarc/mhonarc-2.6.18-r1.ebuild,v 1.5 2012/12/27 08:09:58 armin76 Exp $

inherit perl-app

DESCRIPTION="Perl Mail-to-HTML Converter"
HOMEPAGE="http://www.mhonarc.org/"
SRC_URI="http://www.mhonarc.org/release/MHonArc/tar/MHonArc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ~ppc x86"
IUSE=""

RESTRICT="mirror"

S="${WORKDIR}/${P/mhonarc/MHonArc}"

src_install() {
	sed -e "s|-prefix |-docpath '${D}/usr/share/doc/${PF}' -prefix '${D}'|g" -i Makefile || die 'sed on Makefile failed'
	sed -e "s|installsitelib|installvendorlib|g" -i install.me || die 'sed on install.me failed'
	perl-module_src_install
	prepalldocs
}
