# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.72d-r3.ebuild,v 1.6 2012/04/16 21:17:20 ranger Exp $

EAPI=4

inherit eutils toolchain-funcs

DESCRIPTION="Script for pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="virtual/latex-base
	dev-texlive/texlive-latexextra
	dev-lang/perl
	dev-perl/TimeDate
	dev-perl/Text-Iconv
	dev-perl/File-Which
	app-text/psutils"

src_prepare() {
	epatch "${FILESDIR}/${PN}-ldflags.patch"
	epatch "${FILESDIR}/${PN}-no_html_docs.patch"
	epatch "${FILESDIR}/${PN}-CVE-2008-5368.patch"
	epatch "${FILESDIR}/${P}-warning.patch"
}

src_compile() {
	tc-export CC
	default
}

src_install() {
	einstall prefix="${D}"/usr docdir="${D}"/usr/share/doc docdirname=${PF}
}
