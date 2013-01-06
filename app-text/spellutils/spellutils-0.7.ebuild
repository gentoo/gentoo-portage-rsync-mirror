# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/spellutils/spellutils-0.7.ebuild,v 1.11 2009/01/03 15:37:55 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="spellutils includes 'newsbody' (useful for spellchecking in mails, etc.)"
HOMEPAGE="http://home.worldonline.dk/byrial/spellutils/"
SRC_URI="http://home.worldonline.dk/byrial/spellutils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha ~mips ~hppa amd64"
IUSE="nls"

src_compile() {
	econf $(use_enable nls)
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc NEWS README
}
