# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bins/bins-1.1.29.ebuild,v 1.15 2012/03/25 16:15:20 armin76 Exp $

inherit eutils

DESCRIPTION="Static HTML photo album generator"
HOMEPAGE="http://bins.sautret.org/"
SRC_URI="http://zubro.chez.tiscali.fr/BINS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1-r6
	>=media-gfx/imagemagick-6.2.2.0
	>=dev-perl/ImageSize-2.99
	>=dev-perl/ImageInfo-1.04-r1
	>=dev-perl/IO-String-1.01-r1
	>=dev-perl/HTML-Clean-0.8
	>=dev-perl/HTML-Parser-3.26-r1
	>=dev-perl/HTML-Template-2.6
	>=dev-perl/Locale-gettext-1.01
	>=virtual/perl-Storable-2.04
	>=dev-perl/Text-Iconv-1.2
	>=dev-perl/URI-1.18
	>=dev-perl/libxml-perl-0.07-r1
	dev-perl/Text-Unaccent
	>=dev-perl/XML-DOM-1.39-r1
	>=dev-perl/XML-Grove-0.46_alpha
	>=dev-perl/XML-Handler-YAWriter-0.23
	>=dev-perl/XML-XQL-0.67
	dev-perl/TimeDate
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-install.patch
	sed -i -e  's|MAN="\$PREFIX/man/man1"|MAN="${D}usr/share/man/man1"|' "${S}"/install.sh
}

src_install() {
	echo "" | DESTDIR="${D}" PREFIX="/usr" ./install.sh || die
	# Fix for pathing
	for i in `grep -l portage "${D}"/usr/bin/*`; do
		sed -i -e  "s:${D}:/:" ${i}
	done
	for i in `grep -l "usr\/local\/share" "${D}"/usr/bin/*`; do
		sed -i -e "s:usr\/local\/share:usr\/share:" ${i}
	done

}

pkg_postinst() {
	ewarn
	ewarn "A new XML format is use for pictures and albums description files in"
	ewarn "BINS 1.1.0. There is an utility bins_txt2xml to convert from old"
	ewarn "format to new one."
	ewarn "WARNING: make a backup of your album before proceding to the"
	ewarn "migration, just in case something goes wrong."
	ewarn
}
