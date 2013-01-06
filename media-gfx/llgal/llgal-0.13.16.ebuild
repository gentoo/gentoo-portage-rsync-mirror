# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/llgal/llgal-0.13.16.ebuild,v 1.2 2012/02/06 19:46:23 armin76 Exp $

inherit perl-module

DESCRIPTION="Command-line static web gallery generator"
HOMEPAGE="http://home.gna.org/llgal"
SRC_URI="http://download.gna.org/llgal/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="exif"

LINS="de en it fr"
for i in ${LINS}; do
	IUSE="${IUSE} linguas_${i}"
done

RDEPEND="media-gfx/imagemagick
	 dev-lang/perl
	 dev-perl/ImageSize
	 dev-perl/URI
	 dev-perl/Locale-gettext
	 exif? ( media-libs/exiftool )"

src_compile() {
	emake PREFIX=/usr SYSCONFDIR=/etc MANDIR=/usr/share/man \
	PERL_INSTALLDIRS=vendor || die "Failed to compile"
}

src_install() {
	emake DESTDIR="${D}" LOCALES="${LINGUAS}" PREFIX=/usr SYSCONFDIR=/etc \
		PERL_INSTALLDIRS=vendor MANDIR=/usr/share/man \
		install install-doc install-man DOCDIR=/usr/share/doc/${PF}/ \
		|| die "Failed to install"
	fixlocalpod
	dodoc Changes
}
