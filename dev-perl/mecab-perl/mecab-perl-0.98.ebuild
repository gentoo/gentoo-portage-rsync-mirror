# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mecab-perl/mecab-perl-0.98.ebuild,v 1.3 2012/04/04 08:28:34 jdhore Exp $

inherit perl-module

IUSE=""

DESCRIPTION="Perl binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-*}/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
KEYWORDS="amd64 ~ia64 x86"
SLOT="0"

DEPEND=">=app-text/mecab-${PV}
	dev-lang/perl"

src_install() {

	perl-module_src_install || die
	dohtml bindings.html || die
	dodoc test.pl || die

}
