# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook2X/docbook2X-0.8.8-r3.ebuild,v 1.1 2013/07/29 10:48:04 pinkbyte Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=1 #290284
inherit autotools-utils

DESCRIPTION="Tools to convert docbook to man and info"
SRC_URI="mirror://sourceforge/docbook2x/${P}.tar.gz"
HOMEPAGE="http://docbook2x.sourceforge.net/"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-linux ~x86-solaris"
IUSE="test"
LICENSE="MIT"

# dev-perl/XML-LibXML - although not mentioned upstream is required
# for make check to complete.
DEPEND="dev-lang/perl
	dev-libs/libxslt
	dev-perl/XML-NamespaceSupport
	dev-perl/XML-SAX
	dev-perl/XML-LibXML
	app-text/docbook-xsl-stylesheets
	=app-text/docbook-xml-dtd-4.2*"
RDEPEND="${DEPEND}"

PATCHES=(
	# Patches from debian, for description see patches itself.
	"${FILESDIR}/${P}-filename_whitespace_handling.patch"
	"${FILESDIR}/${P}-preprocessor_declaration_syntax.patch"
	"${FILESDIR}/${P}-error_on_missing_refentry.patch"
	# bug #296112
	"${FILESDIR}/${P}-drop-htmldir.patch"
)
src_prepare() {
	sed -i -e 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/' configure.ac || die 'sed on configure.ac failed'

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html"
		--with-xslt-processor=libxslt
		--program-transform-name='/^docbook2/s,$,.pl,'
	)
	autotools-utils_src_configure
}
