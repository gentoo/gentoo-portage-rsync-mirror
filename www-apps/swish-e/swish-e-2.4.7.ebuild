# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/swish-e/swish-e-2.4.7.ebuild,v 1.3 2012/11/14 14:14:14 jlec Exp $

EAPI=2

inherit perl-module eutils

DESCRIPTION="Simple Web Indexing System for Humans - Enhanced"
HOMEPAGE="http://www.swish-e.org/"
SRC_URI="http://www.swish-e.org/distribution/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="doc perl pdf mp3"

DEPEND=">=sys-libs/zlib-1.1.3
	dev-libs/libxml2
	pdf?  ( >=app-text/poppler-0.12.3-r3[utils] )
	perl? (	dev-perl/libwww-perl
			dev-perl/HTML-Parser
			dev-perl/HTML-Tagset
			dev-perl/MIME-Types
			dev-perl/HTML-Template
			dev-perl/HTML-FillInForm
			dev-perl/Template-Toolkit
			mp3? ( dev-perl/MP3-Tag )
	)"

PATCHES=( "${FILESDIR}/perl-makefile-2.patch" )

pkg_setup() {
	if has_version 'www-apps/swish-e'; then
		ewarn "Your old swish-e indexes may not be compatible with this version."
	fi
}

src_configure() {
	default
	if use perl; then
		cd "${S}/perl"
		chmod u+x "${S}/swish-config"
		myconf="SWISHBINDIR=${S} SWISHIGNOREVER SWISHSKIPTEST"
		perl-module_src_configure
	fi
}

src_compile() {
	#emake -j1 || die "emake failed"
	default
	if use perl ; then
		cd "${S}"/perl
		perl-module_src_compile
	fi
}

src_install() {
#	dobin src/swish-e || die "dobin failed"
	make DESTDIR="${D}" install || die
	dodoc INSTALL README || die

	if use doc; then
		dodir /usr/share/doc/${PF}
		cp -r html conf "${D}"/usr/share/doc/${PF} || die "cp failed"
	fi

	if use perl ; then
		cd "${S}"/perl
		perl-module_src_install
	fi
}

pkg_postinst() {
	einfo "If you wish to be able to index MS Word documents, "
	einfo "emerge app-text/catdoc"
	einfo
	einfo "If you wish to be able to index MS Excel Spreadsheets,"
	einfo "emerge dev-perl/SpreadSheet-ParseExcel and"
	einfo "dev-perl/HTML-Parser"
}
