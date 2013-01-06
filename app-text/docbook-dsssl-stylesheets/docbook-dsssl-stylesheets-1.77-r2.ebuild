# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/docbook-dsssl-stylesheets/docbook-dsssl-stylesheets-1.77-r2.ebuild,v 1.29 2012/12/08 08:42:52 ulm Exp $

inherit sgml-catalog

MY_P=${P/-stylesheets/}
S=${WORKDIR}/${MY_P}
DESCRIPTION="DSSSL Stylesheets for DocBook."
HOMEPAGE="http://wiki.docbook.org/topic/DocBookDssslStylesheets"
SRC_URI="mirror://sourceforge/docbook/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="app-text/sgml-common"

sgml-catalog_cat_include "/etc/sgml/dsssl-docbook-stylesheets.cat" \
	"/usr/share/sgml/docbook/dsssl-stylesheets-${PV}/catalog"
sgml-catalog_cat_include "/etc/sgml/sgml-docbook.cat" \
	"/etc/sgml/dsssl-docbook-stylesheets.cat"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}/${P}.Makefile" Makefile
}

src_compile() {
	return 0
}

src_install() {
	make \
		BINDIR="${D}/usr/bin" \
		DESTDIR="${D}/usr/share/sgml/docbook/dsssl-stylesheets-${PV}" \
		install || die

	dodir /usr/share/sgml/stylesheets/dsssl/

	if [ -d /usr/share/sgml/stylesheets/dsssl/docbook ] &&
		[ ! -L /usr/share/sgml/stylesheets/dsssl/docbook ]
	then
		ewarn "Not linking /usr/share/sgml/stylesheets/dsssl/docbook to"
		ewarn "/usr/share/sgml/docbook/dsssl-stylesheets-${PV}"
		ewarn "as directory already exists there.  Will assume you know"
		ewarn "what you're doing."
		return 0
	fi

	dosym /usr/share/sgml/docbook/dsssl-stylesheets-${PV} \
		/usr/share/sgml/stylesheets/dsssl/docbook
}
