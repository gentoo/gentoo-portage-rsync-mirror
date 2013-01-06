# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/html2latex/html2latex-1.1.ebuild,v 1.15 2009/09/06 20:47:06 ranger Exp $

inherit perl-app

DESCRIPTION="Perl script to convert HTML files into formatted LaTeX"
HOMEPAGE="http://html2latex.sourceforge.net/"
SRC_URI="mirror://sourceforge/html2latex/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

IUSE="imagemagick libwww"

DEPEND="dev-perl/HTML-Tree
	dev-perl/XML-Simple
	imagemagick? ( media-gfx/imagemagick )
	libwww? ( dev-perl/libwww-perl )"

src_compile() {
	# HTML::LaTex
	cd HTML
	perl-module_src_prep
	perl-module_src_compile
}

src_install() {
	dobin html2latex
	doman html2latex.1
	dodoc README TODO

	# HTML::LaTex
	cd HTML
	perl-module_src_install
}
